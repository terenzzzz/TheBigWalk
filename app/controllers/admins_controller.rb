class AdminsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def show
    end

    def view_walkers
        @event = Event.where(id: session[:current_event_id]).first
    end

    def view_marshals 
        @event = Event.where(id: session[:current_event_id]).first
        @marshals = Marshall.all
        @users = Array.new
        @marshals.each do |marshal|
            @user = [User.where(id: marshal.users_id).first, Checkpoint.where(id: marshal.checkpoints_id).first] 
            @users.push(@user)
        end
    end

    def view_pickups
        @event = Event.where(id: session[:current_event_id]).first
    end
end
