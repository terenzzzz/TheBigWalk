class MarshalsController < ApplicationController
    before_action :authenticate_user!
    
    
    def choose_event
        @events = Event.all
    end

    def add_shift
        @checkpoints = Checkpoint.where(events_id: params[:id])
    end

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
        @walker = Participant.where(participant_id: 1)
        #TODO need to get the marshal ID when signs in
        @walker.update(checkpoints_id: 2)
        redirect_to marshals_path
    end
end
