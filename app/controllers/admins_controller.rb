class AdminsController < ApplicationController
    before_action :authenticate_user!
    def index
    end

    def show
    end

    def view_walkers
        @event = Event.where(id: session[:current_event_id]).first
        @routes = Route.where(events_id: session[:current_event_id])
        @falling_behind = Array.new
        @on_pace = Array.new
        @walkers_falling_behind = Array.new
        @Walkers_on_pace = Array.new

        @routes.each do |route|
            @walkers_falling_behind.concat Participant.where(routes_id: route.id, pace: 'Falling Behind!')
            @walkers_falling_behind.each do |walker|
                @falling_walker_and_user = [walker, User.where(id: walker.users_id).first]
                @falling_behind.push(@falling_walker_and_user)
            end
            @Walkers_on_pace.concat Participant.where(routes_id: route.id, pace: 'On Pace.')
            @Walkers_on_pace.each do |walker|
                @on_walker_and_user = [walker, User.where(id: walker.users_id).first]
                @on_pace.push(@on_walker_and_user)
            end
        end
    end

    def view_marshals 
        @event = Event.where(id: session[:current_event_id]).first
        #@marshals = Marshall.all
        #@users = Array.new
        #@marshals.each do |marshal|
        #    @user = [User.where(id: marshal.users_id).first, Checkpoint.where(id: marshal.checkpoints_id).first] 
        #    @users.push(@user)
        #end

        @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
        @checkpoints_and_marshals = Array.new
        @checkpoints.each do |checkpoint|
            @checkpoint_and_marshals = [checkpoint]
            @marshals = Marshall.where(checkpoints_id: checkpoint.id)
            @marshals.each do |marshal|
                @user = User.where(id: m.users_id).first
                @checkpoint_and_marshals.push(@user)
            end
            @checkpoints_and_marshals.push(@checkpoint_and_marshals)
        end
    end

    def view_pickups
        @event = Event.where(id: session[:current_event_id]).first
        @pickups = Pickup.all
    end
end
