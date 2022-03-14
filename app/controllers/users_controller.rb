class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            redirect_to profile_index_path, notice: 'profile was successfully updated.'
        else
            render :edit
        end
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(current_user.id)
    end
    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:avatar,:name,:descrition)
    end
    end