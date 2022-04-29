class MarshalsController < ApplicationController
    before_action :authenticate_user!
    
    before_action do
        user = User.where(id: session[:current_user_id]).first
        tag = Tag.where(id: user.tag_id).first
        if tag.name == "Marshal"
        elsif tag.name == "Admin"
            redirect_to admins_path, notice: 'You dont have access to that page'
        elsif tag.name == "Walker"
            redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
        end
    end

    def choose_event
        @events = Event.all
    end

    def add_shift
        @checkpoints = Checkpoint.where(events_id: params[:id])
       # @marshal = Marshall.where(users_id: session[:marshal_id]).first
        #@checkpoint = Checkpoint.where(name: checkpoint.name)
        #@marshal.update(checkpoints_id: @checkpoint.id)
    end
    
    def index
        @marshal = Marshall.where(users_id: session[:current_user_id]).first
        @marshal.checkpoints_id = params[:id]
        session[:current_checkpoint_id] =params[:id]
    end
 
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
                calc_status = Participant.where(routes_id: previous_linker.route_id, checkpoints_id: previous_linker.checkpoint_id)
                calc_status.each do |stat|
                    time_now = Time.now.utc
                    time_last_checkpoint = CheckpointTime.where(participant_id: stat.id, checkpoint_id: previous_linker.checkpoint_id).first.times
                    time_to_next_checkpoint = linker.advised_time
                    dif = time_now - time_last_checkpoint # seconds
                    on_pace = (time_to_next_checkpoint * 60) - dif
                    if on_pace > 0
                        calc_status.update(status: "On Pace.")
                    else
                        calc_status.update(status: "Falling Behind!")
                    end
                    puts "#####################"
                    puts time_last_checkpoint
                    puts time_now
                    puts dif
                    puts "#####################"
                end

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

        
    end 

    def index
        user = User.where(id: session[:current_user_id]).first
        @marshal = Marshall.where(users_id: user.id).first
        @checkpoint = Checkpoint.where(id: @marshal.checkpoints_id).first
        linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: @checkpoint.id)

        @num_walkers_passed = 0
        @num_walkers_falling = 0 

        linkers.each do |linker|
            linkers_after = RoutesAndCheckpointsLinker.where('position_in_route >= ?', linker.position_in_route).where(route_id: linker.route_id)
            linkers_after.each do |linker_after|
                @num_walkers_passed = @num_walkers_passed + Participant.where(routes_id: linker_after.route_id, checkpoints_id: linker_after.checkpoint_id).size
            end
            @num_walkers_falling = @num_walkers_falling + Participant.where(routes_id: linker.route_id, pace: 'Falling Behind!').size
        end
        
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
