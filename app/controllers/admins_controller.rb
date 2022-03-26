class AdminsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def show
    end

    def create_event_branding
        @events = Event.where(id: session[:current_event_id])
        @events.each do |event|
            @event = event
        end
    end
end
