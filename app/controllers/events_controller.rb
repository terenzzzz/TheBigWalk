class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action do
    user = User.where(id: session[:current_user_id]).first
    tag = Tag.where(id: user.tag_id).first
    if tag.name == "Admin"
    elsif tag.name == "Marshal"
      redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
    elsif tag.name == "Walker"
      redirect_to pick_event_pages_path, notice: 'You dont have access to that page'
    end
  end

  # GET /events
  def index
    @events = Event.all
    @walker = User.ransack(params[:q])
    session.delete(:current_event_id)
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
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.made_public = false
    if @event.save
      session[:current_event_id] = @event.id
      session[:new_event] = 1
      @branding = Branding.new
      @branding.events_id = session[:current_event_id]
      @branding.save
      redirect_to routes_path
    else 
      render :new
    end
  end

  def make_public
    event = Event.where(params.require(:make_public).permit(:id)).first
    event.update(made_public: true)
    redirect_to event
  end

  def make_private
    event = Event.where(params.require(:make_private).permit(:id)).first
    event.update(made_public: false)
    redirect_to event
  end

  # PATCH/PUT /events/1
  def update
    old_name = @event.name.dup
    if @event.update(event_params)
      spreadsheet = Spreadsheet.new
      spreadsheet.update_event(old_name, @event)
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
        walkers = Participant.where(routes_id: route.id)
        walkers.each do |walker|
          times = CheckpointTime.where(participant_id: walker.id)
          times.each do |time|
            time.destroy
          end
          walker.destroy
        end
        spreadsheet = Spreadsheet.new
        spreadsheet.delete_event(@event)
        route.destroy
      end
    end
    #delete the checkpoints
    @events_checkpoints = Checkpoint.where(events_id: @event.id)
    if @events_checkpoints != 0
      @events_checkpoints.each do |checkpoint|
        marshals = Marshall.where(checkpoints_id: checkpoint.id)
        marshals.each do |marshal|
          marshal.update(checkpoints_id: nil)
        end
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
    redirect_to events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :phone_number)
    end
end
