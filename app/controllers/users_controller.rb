class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    
    def show
        @user = User.find(params[:id])

        if !(session[:current_route_id]) || session[:reset_route] == 0
            session[:view_user_id] = params[:id]
            redirect_to pick_route_users_path
        end
        session[:reset_route] = 0

        @participant = Participant.where(user_id: @user.id).first
        @current_route_id=session[:current_route_id]
        @route_checkpoints = Array.new
        
        @routes_linker = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id])
        @checkpoints_for_route = Checkpoint.where(id: @routes_linker)
        @route_checkpoints.concat @checkpoints_for_route

    end

    def pick_route
    end

    def route_picked
        current_route = params.require(:route_picked).permit(:route_id)
        session[:current_route_id] = current_route[:route_id]
        user = User.where(id: session[:view_user_id]).first
        session[:reset_route] = 1
        redirect_to user
    end

    def edit
    end
    
    def update
        if @user.update(user_params)
            #Edit User's Participant_Id
            if Tag.where(id: @user.tag_id).first.name == "Walker"
                spreadsheet = Spreadsheet.new

                walker = Participant.where(routes_id: session[:current_route_id], user_id: @user.id).first
                
                walker.update(params.require(:participant).permit(:participant_id))
                spreadsheet.update_walker_info((Route.where(id: walker.routes_id).first), @user)

                if params[:opted_in] == "1"
                    OptedInLeaderboard.where(user_id: session[:current_user_id]).first.update(opted_in: true)
                    session[:opted_in] = 1
                else
                    OptedInLeaderboard.where(user_id: session[:current_user_id]).first.update(opted_in: false)
                    session[:opted_in] = 0
                end

            #Edit User's Marshal_Id
            elsif Tag.where(id: @user.tag_id).first.name == "Marshal"
                marshal = Marshall.where(checkpoints_id: session[:current_checkpoint_id], users_id: @user.id).first
                marshal.update(params.require(:marshall).permit(:marshal_id))
            end
            redirect_to profile_index_path, notice: 'Profile successfully updated.'
        else
            redirect_to edit_profile_path(current_user), notice: 'Please Check The Detail You Enter.'
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
        params.require(:user).permit(:tag_id, :avatar,:name,:description,:mobile, :donate_link)
    end
end