class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all
    @walker = User.ransack(params[:q])
  end

  # GET /events/1
  def show
    session[:new_event] = 0
    session[:current_event_id] = @event.id
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    session[:new_event] = 0
    @brandings = Branding.where(events_id: session[:current_event_id])
    @brandings.each do |branding|
      @branding = branding
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.save
    session[:current_event_id] = @event.id
    session[:new_event] = 1
    @branding = Branding.new
    @branding.events_id = session[:current_event_id]
    @branding.save
    redirect_to routes_path
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    #delete the routes and the routes and checkpoints linkers
    @events_routes = Route.where(events_id: @event.id)
    if @events_routes != 0
      @events_routes.each do |route|
        @events_routes_and_checkpoints_linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
        if @events_routes_and_checkpoints_linkers != 0
          @events_routes_and_checkpoints_linkers.each do |linker|
            linker.destroy
          end
        end
        route.destroy
      end
    end
    #delete the checkpoints
    @events_checkpoints = Checkpoint.where(events_id: @event.id)
    if @events_checkpoints != 0
      @events_checkpoints.each do |checkpoint|
        checkpoint.destroy
      end
    end
    #delete the branding
    @events_branding = Branding.where(events_id: @event.id)
    if @events_branding != 0
      @events_branding.each do |branding|
        branding.destroy
      end
    end
    @event.destroy
    redirect_to admins_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name)
    end
end
