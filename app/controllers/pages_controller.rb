class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    @users = User.all
    @start_date = Route.find(params[:id]).start_date
    @start_time = Route.find(params[:id]).start_time.strftime("%H:%M:%S")
    session[:current_route_id]=params[:id]
    if current_user.tag.name =='Marshal'
      redirect_to marshals_path
    end

    if current_user.tag.name =='Admin'
      redirect_to admins_path
    end

    @paticipant = Participant.where(user_id:current_user.id, routes_id:session[:current_route_id])
    if @paticipant.first
      redirect_to walkers_path
    end
    
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

    #NOTE - Need to move a load of the variables from haml to the controller for single user leaderboard and leaderboard

    #A list of Participants (NOT users)
    @walkers_for_route = Array.new
    @walkers_for_route.concat Participant.where(routes_id: Route.where(id: session[:current_route_id]).first)
  end

  def single_user_leaderboard
    @leaderboard_participant_id=params[:leaderboard_participant_id]
    @participant = Participant.where(id: @leaderboard_participant_id).first
    @leaderboard_user = User.where(id: @participant.user_id).first
    @leaderboard_user_id = @leaderboard_user.id
    @current_route_id=session[:current_route_id]
    @route_checkpoints = Array.new 
    
    @routes_linker = RoutesAndCheckpointsLinker.where(route_id: session[:current_route_id])
    @checkpoints_for_route = Checkpoint.where(id: @routes_linker)
    @route_checkpoints.concat @checkpoints_for_route

  end

end