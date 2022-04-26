class WalkersController < ApplicationController
    before_action :authenticate_user!

    def check_in
      @lat = 53.381759
      @lon = -1.482212
      @wgs84_point = OsgbConvert::WGS84.new(@lat, @lon, 0)
      @osUKgridPoint = OsgbConvert::OSGrid.from_wgs84(@wgs84_point)
      @osReference = @osUKgridPoint.grid_ref(6)
    end

    def requestCall
      Call.create(user_id:current_user.id)
      redirect_to help_walkers_path, notice: 'Call request successful'
    end


    def check_in_fail
      user = User.where(id: session[:current_user_id]).first
      walker = Participant.where(user_id: user.id).first
      checkpoint_pos = RoutesAndCheckpointsLinker.where(route_id: walker.routes_id, checkpoint_id: walker.checkpoints_id).first.position_in_route
      @linker = RoutesAndCheckpointsLinker.where(position_in_route: (checkpoint_pos + 1), route_id: walker.routes_id).first
      @checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first
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
    end

    def show
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @user = User.find(params[:id])
    end
end
