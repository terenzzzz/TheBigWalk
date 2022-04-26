class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    @users = User.all
    @start_date = Route.find(params[:id]).start_date
    @start_time = Route.find(params[:id]).start_time.strftime("%H:%M:%S")

  end

  def pick_event
    @events = Event.all
  end

  def pick_route
    @routes = Route.where(events_id: params[:id])
    session[:current_event_id]=params[:id]
  end


  # GET /users
  def leaderboard
    #retrieves all users for use in the leaderboard
    @users = User.all
    @current_event_id = session[:current_event_id]
  end

  def single_user_leaderboard
    @leaderboard_participant=params[:leaderboard_participant]
  end

end