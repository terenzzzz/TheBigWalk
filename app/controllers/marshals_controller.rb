class MarshalsController < ApplicationController
    before_action :authenticate_user!

    def change_checkpoint
    end
   
    def end_marshal_shift
    end

    def view_incoming_walkers
    end

    def index
    end

    def end_for_the_day
    end


    def checkin_walker
        @walker = Participant.where(params.require(:checkin_walker).permit(:participant_id)).first
        @marshal = Marshall.where(users_id: session[:marshal_id]).first
        @walker.update(checkpoints_id: @marshal.checkpoints_id)
        redirect_to marshals_path
    end
end
