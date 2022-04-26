class MarshalsController < ApplicationController
    before_action :authenticate_user!

    def change_checkpoint
    end
   
    def end_marshal_shift
    end

    def view_incoming_walkers
        user = User.where(id: session[:current_user_id]).first
        marshal = Marshall.where(users_id: user.id).first
        checkpoint = Checkpoint.where(id: marshal.checkpoints_id).first

        linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: checkpoint.id)
        

        @falling_behind = Array.new
        @on_pace = Array.new
        @walkers_falling_behind = Array.new
        @Walkers_on_pace = Array.new
        linkers.each do |linker|
            previous_linker = RoutesAndCheckpointsLinker.where(position_in_route: (linker.position_in_route - 1), route_id: linker.route_id).first
            if previous_linker
                @walkers_falling_behind.concat Participant.where(routes_id: previous_linker.route_id, pace: 'Falling Behind!', checkpoints_id: previous_linker.checkpoint_id)
                @walkers_falling_behind.each do |walker|
                    @falling_walker_and_user = [walker, User.where(id: walker.user_id).first]
                    @falling_behind.push(@falling_walker_and_user)
                end
                @Walkers_on_pace.concat Participant.where(routes_id: previous_linker.route_id, pace: 'On Pace.', checkpoints_id: previous_linker.checkpoint_id)
                @Walkers_on_pace.each do |walker|
                    @on_walker_and_user = [walker, User.where(id: walker.user_id).first]
                    @on_pace.push(@on_walker_and_user)
                end
            end
        end


        # @event = Event.where(id: session[:current_event_id]).first
        # @routes = Route.where(events_id: session[:current_event_id])
        # @falling_behind = Array.new
        # @on_pace = Array.new
        # @walkers_falling_behind = Array.new
        # @Walkers_on_pace = Array.new
  
        # @routes.each do |route|
        #     @walkers_falling_behind.concat Participant.where(routes_id: route.id, pace: 'Falling Behind!')
        #     @walkers_falling_behind.each do |walker|
        #         @falling_walker_and_user = [walker, User.where(id: walker.user_id).first]
        #         @falling_behind.push(@falling_walker_and_user)
        #     end
        #     @Walkers_on_pace.concat Participant.where(routes_id: route.id, pace: 'On Pace.')
        #     @Walkers_on_pace.each do |walker|
        #         @on_walker_and_user = [walker, User.where(id: walker.user_id).first]
        #         @on_pace.push(@on_walker_and_user)
        #     end
        # end
    end 

    def index
    end

    def end_for_the_day
    end

    #GET
    def checkin_walkers
        @marshal = Marshall.where(users_id: session[:current_user_id]).first
        @checkpoint = Checkpoint.where(id: @marshal.checkpoints_id).first
    end

    #POST
    def checkin_walker
        @walker = Participant.where(params.require(:checkin_walker).permit(:participant_id)).first
        if @walker
            @marshal = Marshall.where(users_id: session[:current_user_id]).first
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
