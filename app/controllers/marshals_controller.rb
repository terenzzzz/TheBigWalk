class MarshalsController < ApplicationController
    before_action :authenticate_user!
    
    before_action do
        user = User.where(id: session[:current_user_id]).first
        tag = Tag.where(id: user.tag_id).first
        if tag.name == "Marshal"
        elsif tag.name == "Admin"
            redirect_to events_path, notice: 'You dont have access to that page'
        elsif tag.name == "Walker"
            redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
        end
    end

    def choose_event
        @marshal = Marshall.where(user_id: current_user.id).first
        @checkpoint = @marshal.checkpoints_id
        if @checkpoint
            redirect_to marshal_path(@checkpoint)
        else
            @events = Event.where(made_public: true)
        end
        
    end

    def add_shift
        @marshal = Marshall.where(user_id: current_user.id).first
        @checkpoints = Checkpoint.where(events_id: params[:id])
        session[:current_event_id] = params[:id]
        MarshalShift.create(current_time: Time.now , status:"Started", marshalls_id:@marshal.id)
    end
    
    #GET
    def change_checkpoint
        @marshal = Marshall.where(user_id: current_user.id).first
        @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
    end
   
    #POST
    def search_checkpoint
<<<<<<< HEAD
        @marshal = Marshall.where(user_id: current_user.id).first
        @checkpoints = Checkpoint.where(name: params[:search][:name])
=======
        @marshal = Marshall.where(users_id: current_user.id).first
        @checkpoints = Checkpoint.where(name:params[:search][:name])
>>>>>>> 04a779240c039392ec4e41bf219d1feb33453331
        render :change_checkpoint
    end

    def end_marshal_shift
    end

    def view_incoming_walkers
        user = User.where(id: session[:current_user_id]).first
        marshal = Marshall.where(user_id: user.id).first
        checkpoint = Checkpoint.where(id: marshal.checkpoints_id).first

        linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: checkpoint.id)
        
        @needs_help = Array.new
        @falling_behind = Array.new
        @on_pace = Array.new
        @walkers_need_help = Array.new
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
                    on_pace = (time_to_next_checkpoint * 60)/dif
                    if on_pace > 1
                        stat.update(pace: "On Pace.")
                    elsif on_pace > 0.65 #if the current pace is 1.54x (ish) bigger than expected, get help
                        stat.update(pace: "Falling Behind!")
                    else
                        stat.update(pace: "Very Far Behind!!")
                    end
                end

                @walkers_need_help.concat Participant.where(routes_id: previous_linker.route_id, pace: 'Very Far Behind!!', checkpoints_id: previous_linker.checkpoint_id)
                @walkers_need_help.each do |walker|
                    @help_walker_and_user = [walker, User.where(id: walker.user_id).first]
                    @needs_help.push(@help_walker_and_user)
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

    def show
        session[:current_checkpoint_id] = params[:id]
        user = User.where(id: session[:current_user_id]).first
        @marshal = Marshall.where(user_id: user.id).first
        @marshal.update(checkpoints_id: params[:id])

        @checkpoint = Checkpoint.where(id: @marshal.checkpoints_id).first
        session[:current_event_id] =  @checkpoint.events_id
        linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: @checkpoint.id)
        @num_walkers_passed = 0
        @num_walkers_falling = 0 
        @num_walkers_help = 0

        linkers.each do |linker|
            previous_linker = RoutesAndCheckpointsLinker.where(position_in_route: (linker.position_in_route - 1), route_id: linker.route_id).first
            linkers_after = RoutesAndCheckpointsLinker.where('position_in_route >= ?', linker.position_in_route).where(route_id: linker.route_id)
            linkers_after.each do |linker_after|
                @num_walkers_passed = @num_walkers_passed + Participant.where(routes_id: linker_after.route_id, checkpoints_id: linker_after.checkpoint_id).size
            end
            @num_total_walkers_to_pass = Participant.where(routes_id: linker.route_id).size
            if previous_linker
                @num_walkers_help = @num_walkers_help + Participant.where(routes_id: linker.route_id, pace: 'Very Far Behind!!', checkpoints_id: previous_linker.checkpoint_id).size
                @num_walkers_falling = @num_walkers_falling + Participant.where(routes_id: linker.route_id, pace: 'Falling Behind!', checkpoints_id: previous_linker.checkpoint_id).size
            end
            #there's probably a way to do it in one line for the last 2
        end
    end

    def end_for_the_day

    end
    def  resume_marshalling
        @marshal = Marshall.where(user_id: session[:current_user_id]).first
        @marshal_shift = MarshalShift.where(marshalls_id: @marshal.id).first
        @marshal_shift.update(status:"Started")
        redirect_to marshal_path(session[:current_checkpoint_id]), notice: 'Marshalling Resumed'
    end
    def  pause_marshalling
        @marshal = Marshall.where(user_id: session[:current_user_id]).first
        @marshal_shift = MarshalShift.where(marshalls_id: @marshal.id).first
        @marshal_shift.update(status:"Paused")
        #MarshalShift.create(current_time:DateTime.now() , status:"Paused", marshalls_id:@marshal.id)
        redirect_to marshal_path(session[:current_checkpoint_id]), notice: 'Marshalling Paused'
    end

    def move_own_way_home
        @marshal = Marshall.where(user_id: session[:current_user_id]).first
        @marshal.update(checkpoints_id: nil)
        @marshal_shift = MarshalShift.where(marshalls_id: @marshal.id).first
        @marshal_shift.update(status:"Finished")
        #MarshalShift.create(current_time: Time.now , status:"Finished", marshalls_id:@marshal.id)
        reset_session
        redirect_to '/'
    end

    def request_pick_up
        @marshal = Marshall.where(user_id: session[:current_user_id]).first
        Pickup.create(user_id: session[:current_user_id], event_id:session[:current_event_id], os_grid: session[:osReference])
        @marshal_shift = MarshalShift.where(marshalls_id: @marshal.id).first
        @marshal_shift.update(status:"Finished")
        #MarshalShift.create(current_time: Time.now , status:"Finished", marshalls_id:@marshal.id)
        reset_session
        redirect_to '/', notice: 'Pick up request successful.'
    end

    #GET
    def checkin_walkers
        @marshal = Marshall.where(user_id: session[:current_user_id]).first
        @checkpoint = Checkpoint.where(id: @marshal.checkpoints_id).first
    end

    #POST
    def checkin_walker
        @walker = Participant.where(params.require(:checkin_walker).permit(:participant_id), event_id: session[:current_event_id]).first
        if @walker
            @marshal = Marshall.where(user_id: session[:current_user_id]).first
            @walker.update(checkpoints_id: @marshal.checkpoints_id)

            #create checkpoint time for walker
            time = Time.now
            @checkpoint_time = CheckpointTime.new
            @checkpoint_time.times = time 
            @checkpoint_time.checkpoint_id = @marshal.checkpoints_id
            @checkpoint_time.participant_id = @walker.id
            @checkpoint_time.save

            #rerank the walker
            #gets walkers at that checkpoint same on route 
            walkers_on_route = Participant.where(routes_id: @walker.routes_id, checkpoints_id: @marshal.checkpoints_id)
            lowest_rank = 0
            #checks whos gone past that checkpoint with lowest rank 
            walkers_on_route.each do |walker|
                #if self dont check??????
                if walker.rank > lowest_rank && walker.rank != @walker.rank
                    lowest_rank = walker.rank
                end
            end
            old_rank = @walker.rank.dup
            #if rank is the same dont update
            #if noone has then they are in 1st
            if (lowest_rank + 1) != @walker.rank
                @walker.update(rank: (lowest_rank + 1))
            end

            #reranks rest
            #old rank and new rank everyone inbetween gets shifted down if rank is increased
            if old_rank > (lowest_rank + 1)
                walkers_rerank = Participant.where(routes_id: @walker.routes_id).where("rank < ?", old_rank).where("rank >= ?", (lowest_rank + 1))
                walkers_rerank.each do |walker|
                    if walker.id != @walker.id
                        walker.update(rank: (walker.rank + 1))
                    end
                end
            end



            #add checkpoint time for walker to spreadsheet
            user = User.where(id: @walker.user_id).first
            route = Route.where(id: @walker.routes_id).first
            checkpoint = Checkpoint.where(id: @walker.checkpoints_id).first
            spreadsheet = Spreadsheet.new
            spreadsheet.update_walker_rank(route, old_rank, user)
            spreadsheet.add_checkpoint_time(route, user, checkpoint)

            redirect_to '/', notice: 'Check In Walker successfully.'
        else
            redirect_to checkin_walkers_marshals_path, notice: 'Invalid Walker ID.'
        end
    end
end
