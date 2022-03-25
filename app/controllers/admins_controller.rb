class AdminsController < ApplicationController
    before_action :authenticate_user!


    def change_checkpoint
    end
   
    def end_marshal_shift
    end

    def index
    end

    def show
    end

    def create_event_checkpoint
        @checkpoints = Checkpoint.all
    end

    def manage_checkpoints
        @checkpoints = Checkpoint.all
    end
end
