class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    @users = User.all
    @start_date = Route.find(1).start_date
    @start_time = Route.find(1).start_time.strftime("%H:%M:%S")

  end

  def pick_event
    @events = Event.all
  end

  def pick_route
    @routes = Route.where(events_id: params[:id])
    # @routes = Route.where(events_id: @event.id)
  end


  # GET /users
  def leaderboard
  #retreives all users for use in the leaderboard
    @users = User.all
  end

end


#class LeaderboardController < ApplicationController
#  def index
#    @users = User.all
#  end
#end
