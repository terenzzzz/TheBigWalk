class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def show
        @user = User.find(params[:id])
    end

    def edit
    end
    
    def update
        if @user.update(user_params)
            if Tag.where(id: @user.tag_id).first.name == "Walker"
                spreadsheet = Spreadsheet.new
                walker = Participant.where(user_id: @user.id).first
                spreadsheet.update_walker_info((Route.where(id: walker.routes_id).first), @user)
            end
            redirect_to profile_index_path, notice: 'profile was successfully updated.'
        else
            render :edit
        end
    end
    

    def destroy
        @user.destroy
        redirect_to '/'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(current_user.id)
    end
    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:tag_id, :avatar,:name,:description,:mobile)
    end
    end