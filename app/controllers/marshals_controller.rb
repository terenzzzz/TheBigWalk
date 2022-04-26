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

    #GET
    def checkin_walkers
        @marshal = Marshall.where(users_id: session[:marshal_id]).first
        @checkpoint = Checkpoint.where(id: @marshal.checkpoints_id).first
    end

    #POST
    def checkin_walker
        @walker = Participant.where(params.require(:checkin_walker).permit(:participant_id)).first
        if @walker
            @marshal = Marshall.where(users_id: session[:marshal_id]).first
            @walker.update(checkpoints_id: @marshal.checkpoints_id)

            time = Time.now
            @checkpoint_time = CheckpointTime.new
            @checkpoint_time.times = time 
            @checkpoint_time.checkpoint_id = @marshal.checkpoints_id
            @checkpoint_time.participant_id = @walker.id
            @checkpoint_time.save

            user = User.where(id: @walker.user_id).first
            route = Route.where(id: @walker.routes_id).first
            checkpoint = Checkpoint.where(id: @walker.checkpoints_id).first
            spreadsheet = Spreadsheet.new
            spreadsheet.add_checkpoint_time(route, user, checkpoint)

            redirect_to marshals_path
        else
            redirect_to checkin_walkers_marshals_path, notice: 'Ivalid walker ID.'
        end
    end
end
