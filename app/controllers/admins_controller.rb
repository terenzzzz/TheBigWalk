class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action do
        user = User.where(id: session[:current_user_id]).first
        tag = Tag.where(id: user.tag_id).first
        if tag.name == "Admin"
        elsif tag.name == "Marshal"
            redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
        elsif tag.name == "Walker"
            redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
        end
    end

    def index
    end

    def show
    end

    def pick_route
    end

    def choose_a_route
        #view page with links, param with route id
        #sets a session with route id
        #redirects to 'view event leaderboard'
    end

    def view_walkers
        @event = Event.where(id: session[:current_event_id]).first
        @routes = Route.where(events_id: session[:current_event_id])
        @needs_help = Array.new
        @falling_behind = Array.new
        @on_pace = Array.new
        @walkers_need_help = Array.new
        @walkers_falling_behind = Array.new
        @Walkers_on_pace = Array.new


        @routes.each do |route|

            @walkers_need_help.concat Participant.where(event_id: session[:current_event_id], pace: 'Very Far Behind!!')
            @walkers_need_help.each do |walker|
                @help_walker_and_user = [walker, User.where(id: walker.user_id).first]
                @needs_help.push(@help_walker_and_user)
            end
            @walkers_falling_behind.concat Participant.where(event_id: session[:current_event_id], pace: 'Falling Behind!')
            @walkers_falling_behind.each do |walker|
                @falling_walker_and_user = [walker, User.where(id: walker.user_id).first]
                @falling_behind.push(@falling_walker_and_user)
            end
            @Walkers_on_pace.concat Participant.where(event_id: session[:current_event_id], pace: 'On Pace.')
            @Walkers_on_pace.each do |walker|
                @on_walker_and_user = [walker, User.where(id: walker.user_id).first]
                @on_pace.push(@on_walker_and_user)
            end
        end
    end

    def view_marshals 
    end

    def view_pickups
        @pickups = Pickup.where(event_id: session[:current_event_id])
    end

    def view_calls
        @calls = Call.where(event_id: session[:current_event_id])
    end

    def make_walker_marshal
        user = User.where(params.require(:make_walker_marshal).permit(:id)).first
        walkers = Participant.where(user_id: user.id)
        marshal = Marshall.new
        marshal.marshal_id = walkers.first.participant_id
        marshal.users_id = user.id
        marshal.checkpoints_id = nil
        marshal.save
        user.tag_id = Tag.where(name: "Marshal").first.id
        user.save
        walkers.each do |walker|
            #times = CheckpointTime.where(participant_id: walker.id)
            spreadsheet = Spreadsheet.new
            spreadsheet.delete_walker(Route.where(id: walker.routes_id).first, user)
            #times.each do |time|
            #    time.destroy
            #end
            walker.destroy
        end
        redirect_to user
    end

    def checkpoint_order
    end

    def route_picked
        current_route = params.require(:route_picked).permit(:route_id)
        session[:current_route_id] = current_route[:route_id]
        session[:reset_route] = 1
        redirect_to leaderboard_pages_path
    end

    def make_user_admin
        user = User.where(params.require(:make_user_admin).permit(:id)).first
        tag = Tag.where(id: user.tag_id).first.name
        if tag == "Walker"
            walkers = Participant.where(user_id: user.id)
            walkers.each do |walker|
                #times = CheckpointTime.where(participant_id: walker.id)
                spreadsheet = Spreadsheet.new
                spreadsheet.delete_walker(Route.where(id: walker.routes_id).first, user)
                #times.each do |time|
                #    time.destroy
                #end
                walker.destroy
            end
        else
            marshal = Marshall.where(users_id: user.id).first
            shifts = MarshalShift.where(marshalls_id: marshal.id)
            shifts.each do |shift|
                shift.destroy
            end
            marshal.destroy
        end
        user.tag_id = Tag.where(name: "Admin").first.id
        user.save
        redirect_to user
    end
end
