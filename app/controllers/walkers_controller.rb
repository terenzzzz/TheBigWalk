class WalkersController < ApplicationController
    before_action :authenticate_user!

    def check_in
        
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
