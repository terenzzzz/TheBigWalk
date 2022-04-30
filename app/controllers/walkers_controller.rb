class WalkersController < ApplicationController
    before_action :authenticate_user!
    before_action do
      user = User.where(id: session[:current_user_id]).first
      tag = Tag.where(id: user.tag_id).first
      if tag.name == "Walker"
      elsif tag.name == "Marshal"
          redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
      elsif tag.name == "Admin"
          redirect_to admins_path, notice: 'You dont have access to that page'
      end
    end

    def check_in
      @lat = session[:lat].to_f
      @lon = session[:lon].to_f
      @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
      @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
      @osReference = @osUKgridPoint.grid_ref(6)
      
    end

    def saveLocation
      #get latitude and longitue
      @lat = params[:lat].to_f
      @lon = params[:lon].to_f
      session[:lat] = @lat
      session[:lon] = @lon
      #conver them to OS Reference
      @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
      @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
      @osReference = @osUKgridPoint.grid_ref(6)
      session[:osReference] = @osReference

      #find next checkpoint
      user = User.where(id: session[:current_user_id]).first
      walker = Participant.where(user_id: user.id).first
      checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

      # need change the os reference
      if @osReference == @checkpoint.os_grid
        redirect_to check_in_walkers_path
      else
        redirect_to check_in_fail_walkers_path
      end

    end

    def sign_up_participant
      participant = Participant.where(routes_id:session[:current_route_id], user_id:session[:current_user_id]).first_or_create(checkpoints_id:"1", routes_id: session[:current_route_id], user_id: current_user.id, event_id: session[:current_event_id], rank: 0)#, opted_in_leaderboard: session[:opted_in])
      participant.save

      # user_id_for_participant = participant.user_id
      # user_opted_in = User.where(id: user_id_for_participant).opted_in
      
      # new_opted_in_entry = OptedInLeaderboard.new(user_id: user_id_for_participant, opted_in: user_opted_in)
      # new_opted_in_entry.save

      #puts "########################################"
      #puts (Participant.where(id: participant.id).first).id
      #puts "########################################"

      # @current_participant_opted_in = Participant.where(routes_id:session[:current_route_id], user_id: session[:current_user_id]).first.opted_in_leaderboard #current_user.id).first.opted_in_leaderboard
      # puts "$$$$$ #{@current_participant_opted_in}"
      # if @current_participant_opted_in #== true
      #   participant.update(opted_in_leaderboard: true)
      #   puts "676767"
      # else
      #   participant.update(opted_in_leaderboard: false)
      #   puts "565656"
      # end
      # puts "current user opted in: #{participant.opted_in_leaderboard} + #{Participant.where(routes_id:session[:current_route_id], user_id:session[:current_user_id]).first_or_create(checkpoints_id:"1", routes_id: session[:current_route_id], user_id: current_user.id, event_id: session[:current_event_id]).id}"

      # puts "And again 1: #{@current_participant_opted_in} \n\n"
      puts "Participant in table: #{Participant.where(routes_id:session[:current_route_id]).first_or_create(checkpoints_id:"1", routes_id: session[:current_route_id], user_id: current_user.id, event_id: session[:current_event_id])}"
      #participant.save
      if participant.save
        redirect_to walkers_path
      else
        redirect_to home_page_path(session[:current_event_id]), notice: 'You dont have access to that page'
      end
  
    end


    def requestCall
      #Need to deal with the event_id
      Call.create(user_id:current_user.id, event_id:session[:current_event_id])
      redirect_to help_walkers_path, notice: 'Call request successful'
    end

    def requestPickUp
      #Need to deal with the event_id
      Pickup.create(user_id:current_user.id, event_id:session[:current_event_id], os_grid: session[:osReference])
      redirect_to help_walkers_path, notice: 'Pick up request successful'
    end


    def check_in_fail
      user = User.where(id: session[:current_user_id]).first
      walker = Participant.where(user_id: user.id).first
      checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

      @lat = session[:lat].to_f
      @lon = session[:lon].to_f
      @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
      @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
      @osReference = @osUKgridPoint.grid_ref(6)
    end

    def help
    end

    def drop_out
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
      user = User.where(id: session[:current_user_id]).first
      puts "User: #{user.id}"
      @walker = Participant.where(user_id: user.id).first
      puts "Route ID: #{@walker}"
      checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: @walker.routes_id, checkpoint_id: @walker.checkpoints_id).first.position_in_route
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: @walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

      @advisedTime = @linker.advised_time

      #NEEDS FIXING, USER DOESN'T HAVE AN EMPTY TIME WHEN THEY SIGN UP (I think that's the issue or something like that) \/\/
      if CheckpointTime.where(checkpoint_id: @walker.checkpoints_id, participant_id: @walker.id).first
        @time = CheckpointTime.where(checkpoint_id: @walker.checkpoints_id, participant_id: @walker.id).first.times
      else
        @time = DateTime.new()
      end
    end

    def show
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
