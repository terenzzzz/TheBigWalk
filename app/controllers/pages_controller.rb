class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    @users = User.all
    @start_date = Route.find(params[:id]).start_date.strftime("%Y-%m-%d")
    @start_time = Route.find(params[:id]).start_time.strftime("%H:%M:%S")
    session[:current_route_id]=params[:id]
    # if not walker, skip this page
    if current_user.tag.name =='Marshal'
      redirect_to marshals_path
    end

    if current_user.tag.name =='Admin'
      redirect_to events_path
    end

    @paticipant = Participant.where(user_id:current_user.id, routes_id:session[:current_route_id])
    @paticipantEvent = Participant.where(user_id:current_user.id, event_id: session[:current_event_id])

    @current_time = Time.now.strftime("%H:%M:%S")
    @current_date = Time.now.strftime("%Y-%m-%d")

    if @paticipant.first
      if @current_date > @start_date
        redirect_to walker_path(params[:id])
      elsif @current_date == @start_date && @current_time > @start_time 
        redirect_to walker_path(params[:id])
      end
    end
    
  end

  def pick_event
    @events = Event.where(made_public: true)
  end

  def pick_route
    @routes = Route.where(event_id: params[:id])
    session[:current_event_id]=params[:id]
  end


  # GET /users
  def leaderboard
    
    #retrieves all users for use in the leaderboard
    @users = User.all
    @current_event_id = session[:current_event_id]

    @walkers_for_route = Array.new
    @walkers_for_route.concat Participant.where(routes_id: Route.where(id: session[:current_route_id]).first).order("rank ASC")

    @all_route_checkpoints = Array.new

    @all_route_checkpoint_linkers = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id])
    @all_route_checkpoint_linkers.each do |linker|
      @all_route_checkpoints.concat Checkpoint.where(id: linker.checkpoint_id)
    end
    
    @current_user = User.where(id: session[:current_user_id]).first

  end

  def single_user_leaderboard
    @leaderboard_user_id=params[:leaderboard_user_id]

    #needs the route
    @participant = Participant.where(user_id: @leaderboard_user_id, event_id: session[:current_event_id]).first
    @leaderboard_user = User.where(id: @leaderboard_user_id).first
    @current_route_id=session[:current_route_id]
    @route_checkpoints = Array.new 
    
    @routes_linker = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id])
    @checkpoints_for_route = Checkpoint.where(id: @routes_linker)
    @route_checkpoints.concat @checkpoints_for_route

  end

end
