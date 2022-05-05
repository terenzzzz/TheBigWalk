class WalkersController < ApplicationController
  before_action :authenticate_user!
  before_action do
    # Check role
    user = User.where(id: session[:current_user_id]).first
    tag = Tag.where(id: user.tag_id).first
    if tag.name == "Walker"
    elsif tag.name == "Marshal"
      redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
    elsif tag.name == "Admin"
      redirect_to events_path, notice: 'You dont have access to that page'
    end
  end

  def check_in
    #find next checkpoint
    user = User.where(id: session[:current_user_id]).first
    walker = Participant.where(user_id: user.id).first
    checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
    @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
    @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

    # Compare current location with checkpoint location
    if session[:osReference] == @checkpoint.os_grid
      walker.update(pace: "On Pace.")
      walker.update(checkpoints_id: @checkpoint.id)
      #create checkpoint time for walker
      time = Time.now
      checkpoint_time = CheckpointTime.new
      checkpoint_time.times = time 
      checkpoint_time.checkpoint_id = @checkpoint.id
      checkpoint_time.participant_id = walker.id
      checkpoint_time.save
      #rerank the walker
      #gets walkers at that checkpoint same on route 
      walkers_on_route = Participant.where(routes_id: walker.routes_id, checkpoints_id: @checkpoint.id)

      lowest_rank = 0
      #checks whos gone past that checkpoint with lowest rank 
      walkers_on_route.each do |walkers|
        if walkers.rank > lowest_rank && walkers.rank != walker.rank
          lowest_rank = walkers.rank
        end
      end
      old_rank = walker.rank.dup
      #if rank is the same dont update
      #if noone has then they are in 1st
      if (lowest_rank + 1) != walker.rank
        walker.update(rank: (lowest_rank + 1))
      end

      #reranks rest
      #old rank and new rank everyone inbetween gets shifted down if rank is increased
      if old_rank > (lowest_rank + 1)
        walkers_rerank = Participant.where(routes_id: walker.routes_id).where("rank < ?", old_rank).where("rank >= ?", (lowest_rank + 1))
        walkers_rerank.each do |walkers|
          if walkers.id != walker.id
            walkers.update(rank: (walkers.rank + 1))
          end
        end
      end

      user = User.where(id: walker.user_id).first
      route = Route.where(id: walker.routes_id).first
      checkpoint = Checkpoint.where(id: walker.checkpoints_id).first
      spreadsheet = Spreadsheet.new
      spreadsheet.update_walker_rank(route, old_rank, user)
      spreadsheet.add_checkpoint_time(route, user, checkpoint)
      redirect_to walker_path(session[:current_route_id]), notice: "Check In Succeffully"
    else
      redirect_to check_in_fail_walkers_path
    end
  end

  def saveLocation
    #get latitude and longitue 
    @lat = params[:lat].to_f
    @lon = params[:lon].to_f
    session[:lat] = @lat
    session[:lon] = @lon
    #conver them to OS Reference(Method 1)
    # @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
    # @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
    # @osReference = @osUKgridPoint.grid_ref(6)

    #conver them to OS Reference(Method 2)
    osgb36point = OSGB_WGS84::WGS84_to_OSGB36(@lat,@lon, 0)
    oslat = osgb36point[0]
    oslon = osgb36point[1]
    osUKgridPoint = OSGB_WGS84::OSGB36_to_OSNG(oslat,oslon)
    easting  = osUKgridPoint[0].round
    northing = osUKgridPoint[1].round
    @osReference = OSGB_WGS84::OSNG_numbers_to_letters(easting,northing, 6)

    # Pass to session and redirect to home page
    session[:osReference] = @osReference
    redirect_to walker_path(session[:current_route_id]), notice:"Your location has been updated."
  end

  def sign_up_participant
    # Give Participant random participant_number
    random_number = 0
    (1000..1999).each do |id| 
      walker_ids = Participant.where(participant_id: id).first
      if !walker_ids
        random_number = id
        break
      end
    end
    #Update checkpoint
    checkpoint_id = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id], position_in_route: "1").first.checkpoint_id
    participant = Participant.where(routes_id:session[:current_route_id], user_id:session[:current_user_id]).first_or_create(participant_id: random_number, checkpoints_id:checkpoint_id, routes_id: session[:current_route_id], user_id: session[:current_user_id], event_id: session[:current_event_id], rank: (Participant.where(routes_id:session[:current_route_id]).size + 1))#, opted_in_leaderboard: session[:opted_in])
    participant.save
    route = Route.where(id: session[:current_route_id]).first
    user =  User.where(id:session[:current_user_id]).first
    start_date = route.start_date
    start_time = route.start_time
    date_time = DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec, start_time.zone)
    CheckpointTime.where(participant_id: participant.id, checkpoint_id: checkpoint_id).first_or_create(times: date_time, participant_id: participant.id, checkpoint_id: checkpoint_id)
    spreadsheet = Spreadsheet.new
    spreadsheet.add_walker(route, user)

    
    if participant.save
      redirect_to walker_path(session[:current_route_id])
    else
      redirect_to home_page_path(session[:current_event_id]), notice: 'You dont have access to that page.'
    end

  end


  def requestCall
    #Create a call record
    Call.create(user_id:current_user.id, event_id:session[:current_event_id])
    redirect_to help_walkers_path, notice: 'Call request successful.'
  end

  def requestPickUp
    #Create a pick up record
    route = Route.where(id: session[:current_route_id]).first
    user = User.where(id: session[:current_user_id]).first
    Pickup.create(user_id:current_user.id, event_id:session[:current_event_id], os_grid: session[:osReference])
    spreadsheet = Spreadsheet.new
    spreadsheet.walker_pickup(route, user)
    redirect_to help_walkers_path, notice: 'Pick up request successful.'
  end


  def check_in_fail
    # If location not match, redirect to this page
    user = User.where(id: session[:current_user_id]).first
    walker = Participant.where(user_id: user.id).first
    checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
    @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
    @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

    @lat = session[:lat].to_f
    @lon = session[:lon].to_f
    @osReference = session[:osReference]
  end

  def help
    @findEvent = Event.where(id: session[:current_event_id]).first
    @head_marshal_num = @findEvent.phone_number
  end

  def drop_out
  end
  
  def make_own_way_home
    walker = Participant.where(user_id: session[:current_user_id]).first
    route = Route.where(id: walker.routes_id).first
    user = User.where(id: walker.user_id).first
    spreadsheet = Spreadsheet.new
    spreadsheet.walker_drop_out(route, user)
    #times = CheckpointTime.where(participant_id: walker.id)
    #times.each do |time|
    #  time.destroy
    #end
    walker.destroy
    reset_session
    redirect_to '/'
  end


  def checkpoint_info
    user = User.where(id: session[:current_user_id]).first
    walker = Participant.where(user_id: user.id).first
    checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
    @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
    @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first
  end
  
  def search
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end

  def inbox
  end

  def index
    
  end

  def show
    ####
    #puts "656565 #{params[:id]}"
    #params_id = params[:id]
    #session[:current_route_id] = params_id[:route_id]

    
    #####
    user = User.where(id: session[:current_user_id]).first
    puts "User: #{user.id}"
    @walker = Participant.where(user_id: user.id, routes_id: params[:id]).first
    puts "Route ID: #{@walker}"
    
    checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: @walker.routes_id, checkpoint_id: @walker.checkpoints_id).first.position_in_route
    if checkpoint_pos == RoutesAndCheckpointsLinker.where(route_id: @walker.routes_id).size
      
    else
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: @walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first
      #what happens when they finish
      @advisedTime = @linker.advised_time

      if CheckpointTime.where(checkpoint_id: @walker.checkpoints_id, participant_id: @walker.id).first
        @time = CheckpointTime.where(checkpoint_id: @walker.checkpoints_id, participant_id: @walker.id).first.times
      else
        #@time = DateTime.new()
        #event starts
        route = Route.where(id: @walker.routes_id).first
        start_time = route.start_time
        start_date = route.start_date
        @time = DateTime.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min, start_time.sec, start_time.zone)
      end
    end
  end
  
  private 
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @user = User.find(params[:id])
  end

  def report_params
    params.permit(:subject, :description)
  end
end
