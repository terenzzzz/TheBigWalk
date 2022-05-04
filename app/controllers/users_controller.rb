class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    
    def show
        @user = User.find(params[:id])

        if !(session[:current_route_id]) || session[:reset_route] == 0
            session[:view_user_id] = params[:id]
            redirect_to pick_route_users_path
        end
        session[:reset_route] = 0

        #####

        puts "@@@@@ CUrrent route id: #{session[:current_route_id]}"
        @leaderboard_user_id=params[:leaderboard_user_id]

        @participant = Participant.where(user_id: @leaderboard_user_id).first
        @leaderboard_user = User.where(id: @leaderboard_user_id).first
        puts "*****&& #{@leaderboard_user}"
        @current_route_id=session[:current_route_id]
        @route_checkpoints = Array.new 
        
        # CURRENTLY THIS \/ is not returning anything (length = 0)
        # Since it works in the normal single user leaderboard, there must be something
        #    that is not working. Maybe the current user is needed 
        @routes_linker = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id])
        puts "::::: %%% #{@routes_linker.length()}"
        @checkpoints_for_route = Checkpoint.where(id: @routes_linker)
        puts "¢¢¢ RACL #{@routes_linker.length()} ++ #{@checkpoints_for_route.length()}"
        @route_checkpoints.concat @checkpoints_for_route
        puts "&&&&&&&&&^^^^^^ #{@route_checkpoints}"

        #####

    end

    def pick_route
    end

    def route_picked
        session[:current_route_id] = params.require(:route_picked).permit(:route_id)
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