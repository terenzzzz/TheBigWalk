class RoutesController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @routes = Route.where(events_id: session[:current_event_id])
    @events = Event.where(id: session[:current_event_id])
    @events.each do |event|
      @event = event
    end
  end

  # GET /events/1
  def show
    session[:new_event] = 0
    session[:current_event_id] = @event.id
  end

  # GET /events/new
  def new
    @route = Route.new
    session[:return_to] ||= request.referer
  end

  # GET /events/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /events
  def create
    @route = Route.new(route_params)
    @route.events_id = session[:current_event_id]
    @route.save
    redirect_to session.delete(:return_to)
  end

  # PATCH/PUT /events/1
  def update
    @route.update(route_params)
    redirect_to session.delete(:return_to)
  end

  # DELETE /events/1
  def destroy
    @events_routes_and_checkpoints_linkers = RoutesAndCheckpointsLinker.where(route_id: @route.id)
    if @events_routes_and_checkpoints_linkers != 0
      @events_routes_and_checkpoints_linkers.each do |linker|
        linker.destroy
      end
    end
    @route.destroy
    redirect_to admins_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @route = Route.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def route_params
      params.require(:route).permit(:name, :start_date, :start_time, :course_length)
    end
end
