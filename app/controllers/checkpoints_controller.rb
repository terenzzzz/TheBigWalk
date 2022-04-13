class CheckpointsController < ApplicationController
  before_action :set_checkpoint, :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /checkpoints
  def index
    @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
    @brandings = Branding.where(events_id: session[:current_event_id])
    @brandings.each do |branding|
      @branding = branding
    end
    @events = Event.where(id: session[:current_event_id])
    @events.each do |event|
      @event = event
    end
  end

  # GET /checkpoints/1
  def show
  end

  # GET /checkpoints/new
  def new
    @checkpoint = Checkpoint.new
    @linker = RoutesAndCheckpointsLinker.new
    @routes = Route.where(events_id: session[:current_event_id])
    session[:return_to] ||= request.referer
  end

  # GET /checkpoints/1/edit
  def edit
    @routes = Route.where(events_id: session[:current_event_id])
    session[:return_to] ||= request.referer
  end

  # POST /checkpoints
  def create
    #creates the new checkpoint
    @checkpoint = Checkpoint.new(checkpoint_params)
    @checkpoint.events_id = session[:current_event_id]
    @checkpoint.save 
    #gets the selected routes
    @route_ids = params[:selected_routes]
    session[:linker_route_ids] = @route_ids
    session[:linker_route_ids_index] = 0
    session[:linker_check_id] = @checkpoint.id
    #adds each to route with the checkpoint to the linker table
    if @route_ids
      @route_ids.each do |id|
        @linker = RoutesAndCheckpointsLinker.new
        @linker.checkpoint_id = @checkpoint.id
        @linker.route_id = id
        @linker.save
      end
      #finds the next linker and redirects to it
      @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
      @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id)
      @route.each do |route|
        redirect_to edit_routes_and_checkpoints_linker_path(route)
      end
    else
      redirect_to session.delete(:return_to)
    end
  end

  # PATCH/PUT /checkpoints/1
  def update
    @checkpoint.update(checkpoint_params)
    #redirect_to session.delete(:return_to)
    #get the selected routes
    @route_ids = params[:selected_routes]
    session[:linker_route_ids] = @route_ids
    session[:linker_route_ids_index] = 0
    session[:linker_check_id] = @checkpoint.id
    #check if the routes already are already in the linker with the checkpoint
    @routes = Route.where(events_id: @checkpoint.events_id)
    @routes.each do |route|
      #doesnt delete final one as there is no session to check against
      if (RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && !(session[:linker_route_ids].include? (route.id).to_s))
        #delete from linker table
        @linker = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: route.id)
        @linker.each do |linker|
          linker.destroy
        end
      elsif !RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && (session[:linker_route_ids].include? (route.id).to_s) 
        #add to linker table
        @linker = RoutesAndCheckpointsLinker.new
        @linker.checkpoint_id = @checkpoint.id
        @linker.route_id = route.id
        @linker.save
      end
    end 
    #finds the next linker and redirects to it or goes to index
    if @route_ids
      @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
      @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id)
      @route.each do |route|
        redirect_to edit_routes_and_checkpoints_linker_path(route)
      end
    else
      redirect_to session.delete(:return_to)
    end
  end

  # DELETE /checkpoints/1
  def destroy
    @events_routes_and_checkpoints_linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: @checkpoint.id)
    if @events_routes_and_checkpoints_linkers != 0
      @events_routes_and_checkpoints_linkers.each do |linker|
        linker.destroy
      end
    end
    @checkpoint.destroy
    redirect_to session.delete(:return_to)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkpoint
      @checkpoint = Checkpoint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checkpoint_params
      params.require(:checkpoint).permit(:name, :os_grid)
    end
end
