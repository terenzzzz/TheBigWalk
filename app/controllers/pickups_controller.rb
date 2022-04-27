class PickupsController < ApplicationController
  before_action :set_pickup, only: [:show, :edit, :update, :destroy]

  # GET /pickups
  def index
    @event = Event.where(id: session[:current_event_id]).first
    @pickups = Pickup.all
  end

  # GET /pickups/1
  def show
  end

  # GET /pickups/new
  def new
    @pickup = Pickup.new
  end

  # GET /pickups/1/edit
  def edit
  end

  # POST /pickups
  def create
    @pickup = Pickup.new(pickup_params)

    if @pickup.save
      redirect_to @pickup, notice: 'Pickup was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pickups/1
  def update
    if @pickup.update(pickup_params)
      redirect_to @pickup, notice: 'Pickup was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pickups/1
  def destroy
    @pickup.destroy
    redirect_to view_pickups_admins_path, notice: 'Pickup was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pickup
      @pickup = Pickup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pickup_params
      params.require(:pickup).permit(:os_grid)
    end
end
