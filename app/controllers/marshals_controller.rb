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
        #TODO this needs changing but should be sorta accurate to the code 
        #needs to be able to access the participants dont know how
        #@walker = Participants.find(params[:participant_id])
        #need to have access to marshal info
        #@walker.check_point_id = Marshal.checkPoint_id
        #@walker.save
        redirect_to marshals_path
    end
end
