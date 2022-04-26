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
    end

    def checkpoing_info
    end

    def help
    end

    def drop_out
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
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @user = User.find(params[:id])
    end
end
