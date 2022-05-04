class ProfileController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def account
    end
    
    def index
        @route_id = session[:current_route_id]
        if current_user.tag.name =='Marshal'
            @marshal_id = Marshall.where(checkpoints_id: session[:current_checkpoint_id], users_id: current_user.id).first.marshal_id
        end
        
        if current_user.tag.name =='Walker'
            @participant_id = Participant.where(routes_id: @route_id, user_id: current_user.id).first.participant_id
        end

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(current_user.id)
    end
    
    end