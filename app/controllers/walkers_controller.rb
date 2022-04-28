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
      @lat = params[:lat].to_f
      @lon = params[:lon].to_f
      session[:lat] = @lat
      session[:lon] = @lon
      @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
      @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
      @osReference = @osUKgridPoint.grid_ref(6)
      # need change the os reference
      if @osReference == 'SJ353876'
        redirect_to check_in_walkers_path
      else
        redirect_to check_in_fail_walkers_path
      end

    end

    def sign_up_participant
      participant = Participant.create(checkpoints_id:"1", routes_id: session[:current_route_id], user_id: current_user.id, event_id: session[:current_event_id])
      participant.save
      if participant.save
        redirect_to walkers_path
      else
        redirect_to home_page_path(session[:current_event_id]), notice: 'You dont have access to that page'
      end
  
    end


    def requestCall
      #Need to deal with the event_id
      Call.create(user_id:current_user.id, event_id:'1')
      redirect_to help_walkers_path, notice: 'Call request successful'
    end

    def requestPickUp
      #Need to deal with the event_id
      Pickup.create(user_id:current_user.id, event_id:'1')
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
      walker = Participant.where(user_id: user.id).first
      checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first

      @advisedTime = @linker.advised_time
      @time = CheckpointTime.where(checkpoint_id: walker.checkpoints_id, participant_id: walker.id).first.times
      # @start_date = Route.find(params[:id]).start_date
      # @start_time = Route.find(params[:id]).start_time.strftime("%H:%M:%S")
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
