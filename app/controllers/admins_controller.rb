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
                @falling_walker_and_user = [walker, User.where(id: walker.user_id).first]
                @falling_behind.push(@falling_walker_and_user)
            end
            @Walkers_on_pace.concat Participant.where(routes_id: route.id, pace: 'On Pace.')
            @Walkers_on_pace.each do |walker|
                @on_walker_and_user = [walker, User.where(id: walker.user_id).first]
                @on_pace.push(@on_walker_and_user)
            end
        end
    end

    def view_marshals 
        @event = Event.where(id: session[:current_event_id]).first

        @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
        @checkpoints_and_marshals = Array.new
        @checkpoints.each do |checkpoint|
            @checkpoint_and_marshals = [checkpoint]
            @marshals = Marshall.where(checkpoints_id: checkpoint.id)
            @marshals.each do |marshal|
                @user = User.where(id: marshal.users_id).first
                @checkpoint_and_marshals.push(@user)
            end
            @checkpoints_and_marshals.push(@checkpoint_and_marshals)
        end
    end

    def view_pickups
        @pickups = Pickup.where(event_id: session[:current_event_id])
    end

    def view_calls
        @calls = Call.where(event_id: session[:current_event_id])
    end

    def make_walker_marshal
        user = User.where(params.require(:make_walker_marshal).permit(:id)).first
        walker = Participant.where(user_id: user.id).first
        marshal = Marshall.new
        marshal.marshal_id = walker.participant_id
        marshal.users_id = user.id
        marshal.checkpoints_id = walker.checkpoints_id
        marshal.save
        user.tag_id = Tag.where(name: "Marshal").first.id
        user.save
        times = CheckpointTime.where(participant_id: walker.id)
        times.each do |time|
            time.destroy
        end
        walker.destroy
        redirect_to user
    end

    def make_user_admin
        user = User.where(params.require(:make_user_admin).permit(:id)).first
        tag = Tag.where(id: user.tag_id).first.name
        if tag == "Walker"
            walker = Participant.where(user_id: user.id).first
            times = CheckpointTime.where(participant_id: walker.id)
            times.each do |time|
                time.destroy
            end
            walker.destroy
        else
            Marshall.where(users_id: user.id).first.destroy
        end
        user.tag_id = Tag.where(name: "Admin").first.id
        user.save
        redirect_to user
    end
end
