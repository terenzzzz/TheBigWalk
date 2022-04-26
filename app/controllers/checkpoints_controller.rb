class CheckpointsController < ApplicationController
  before_action :set_checkpoint, :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /checkpoints
  def index
    @checkpoints = Checkpoint.where(events_id: session[:current_event_id])
    @branding = Branding.where(events_id: session[:current_event_id]).first
    @event = Event.where(id: session[:current_event_id]).first
  end

  # GET /checkpoints/1
  def show
  end

  # GET /checkpoints/new
  def new
    @checkpoint = Checkpoint.new
    @linker = RoutesAndCheckpointsLinker.new
    #@routes = Route.where(events_id: session[:current_event_id])
  end

  # GET /checkpoints/1/edit
  def edit
    #@routes = Route.where(events_id: session[:current_event_id])
  end

  # POST /checkpoints
  def create
    #creates the new checkpoint
    @checkpoint = Checkpoint.new(checkpoint_params)
    @checkpoint.events_id = session[:current_event_id]
    if @checkpoint.save 

      #gets the selected routes
      @route_ids = params[:selected_routes]
      session[:linker_route_ids] = @route_ids
      session[:linker_route_ids_index] = 0
      session[:linker_check_id] = @checkpoint.id
      new_linkers = Array.new
    
      #adds each to route with the checkpoint to the linker table
      if @route_ids
        @route_ids.each do |id|
          
          @linker = RoutesAndCheckpointsLinker.new
          @linker.checkpoint_id = @checkpoint.id
          @linker.distance_from_start = 0
          @linker.route_id = id
          @linker.position_in_route = 0
          @linker.save
          new_linkers.push(@linker.id)
        end
        session[:new_linkers] = new_linkers
        #finds the next linker and redirects to it
        @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
        @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id)
        @route.each do |route|
          redirect_to edit_routes_and_checkpoints_linker_path(route)
        end
      else
        redirect_to checkpoints_path
      end
    else
      render :new
    end
  end

  # PATCH/PUT /checkpoints/1
  def update
    spreadsheet = Spreadsheet.new
    old_checkpoint_name = @checkpoint.name.dup
    if @checkpoint.update(checkpoint_params)

      #get the selected routes
      @route_ids = params[:selected_routes]
      if @route_ids
        @route_ids.each do |id|
          spreadsheet.update_checkpoint_name((Route.where(id: id).first), @checkpoint)
        end
      end
      session[:linker_route_ids] = @route_ids
      session[:linker_route_ids_index] = 0
      session[:linker_check_id] = @checkpoint.id
      new_linkers = Array.new

      #check if the routes are already in the linker with the checkpoint
      @routes = Route.where(events_id: @checkpoint.events_id)
      @routes.each do |route|
        if RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && (!@route_ids || !(session[:linker_route_ids].include? (route.id).to_s))
          #delete from linker table
          @linker = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: route.id)
          @linker.each do |linker|
            spreadsheet.delete_checkpoint(route, old_checkpoint_name, linker.position_in_route)
            linker.destroy
          end
        elsif !RoutesAndCheckpointsLinker.exists?(checkpoint_id: session[:linker_check_id], route_id: route.id) && (@route_ids && (session[:linker_route_ids].include? (route.id).to_s)) 
          #add to linker table
          @linker = RoutesAndCheckpointsLinker.new
          @linker.checkpoint_id = @checkpoint.id
          @linker.route_id = route.id
          @linker.distance_from_start = 0
          @linker.position_in_route = 0
          @linker.save
          new_linkers.push(@linker.id)
        end
      end
      session[:new_linkers] = new_linkers
      #finds the next linker and redirects to it or goes to index
      if @route_ids
        @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
        @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id).first
        redirect_to edit_routes_and_checkpoints_linker_path(@route)
      else
        redirect_to checkpoints_path
      end
    else
      render :edit
    end
  end

  # DELETE /checkpoints/1
  def destroy
    @events_routes_and_checkpoints_linkers = RoutesAndCheckpointsLinker.where(checkpoint_id: @checkpoint.id)
    if @events_routes_and_checkpoints_linkers != 0
      @events_routes_and_checkpoints_linkers.each do |linker|
        spreadsheet = Spreadsheet.new
        spreadsheet.delete_checkpoint((Route.where(id: linker.route_id).first), @checkpoint, linker.position_in_route)
        linker.destroy
      end
    end
    @checkpoint.destroy
    redirect_to checkpoints_path
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
