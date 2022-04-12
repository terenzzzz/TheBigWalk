class CheckpointsController < ApplicationController
  before_action :set_checkpoint, :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /checkpoints
  def index
    @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
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
  end

  # PATCH/PUT /checkpoints/1
  def update
    @checkpoint.update(checkpoint_params)
    redirect_to session.delete(:return_to)
    #get the selected routes
    @route_ids = params[:selected_routes]
    session[:linker_route_ids] = @route_ids
    session[:linker_route_ids_index] = 0
    session[:linker_check_id] = @checkpoint.id
    #check if the routes already are already in the linker with the checkpoint
    @routes = Route.where(events_id: @checkpoint.events_id)
    @routes.each do |route|
      puts session[:linker_route_ids]
      puts route.id
      puts @ids
      @man = Array.new(2, 1000)
      puts @man
      #puts !((session[:linker_route_ids].find_index(route.id)).nil?)
      if (RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && !(session[:linker_route_ids].include? route.id))
        #delete from linker table
        @linker = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: route.id)
        @linker.each do |linker|
          linker.destroy
        end
        #works but delets both
      elsif !RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && (session[:linker_route_ids].include? route.id) 
        #add to linker table
        @linker = RoutesAndCheckpointsLinker.new
        @linker.checkpoint_id = @checkpoint.id
        @linker.route_id = route.id
        @linker.save
        #doesnt check properly
      end
    end 
    #finds the next linker and redirects to it
    @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
    @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id)
    @route.each do |route|
      #redirect_to edit_routes_and_checkpoints_linker_path(route)
    end
  end

  # DELETE /checkpoints/1
  def destroy
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
