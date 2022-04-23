class RoutesController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @routes = Route.where(events_id: session[:current_event_id])
    @event = Event.where(id: session[:current_event_id]).first
  end

  # GET /events/1
  def show
    session[:new_event] = 0
    session[:current_event_id] = @event.id
  end

  # GET /events/new
  def new
    @route = Route.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @route = Route.new(route_params)
    @route.events_id = session[:current_event_id]
    if @route.save
      spreadsheet = Spreadsheet.new
      spreadsheet.add_route("#{Event.where(id: @route.events_id).first.name} #{route_params[:name]}")
      redirect_to routes_path
    else  
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    old_route = @route.dup
    if @route.update(route_params)
      spreadsheet = Spreadsheet.new
      spreadsheet.update_route("#{Event.where(id: old_route.events_id).first.name} #{old_route.name}", "#{Event.where(id: old_route.events_id).first.name} #{route_params[:name]}")
      redirect_to routes_path
    else  
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @events_routes_and_checkpoints_linkers = RoutesAndCheckpointsLinker.where(route_id: @route.id)
    if @events_routes_and_checkpoints_linkers != 0
      @events_routes_and_checkpoints_linkers.each do |linker|
        linker.destroy
      end
    end
    spreadsheet = Spreadsheet.new
    spreadsheet.delete_route("#{Event.where(id: @route.events_id).first.name} #{@route.name}")
    @route.destroy
    redirect_to routes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @route = Route.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def route_params
      params.require(:route).permit(:name, :start_date, :start_time, :end_date_time, :course_length)
    end
end
