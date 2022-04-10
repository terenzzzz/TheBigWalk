class BrandingsController < ApplicationController
  before_action :set_branding, only: [:show, :edit, :update, :destroy]

  # GET /brandings
  def index
    @brandings = Branding.all
  end

  # GET /brandings/1
  def show
  end

  # GET /brandings/new
  def new
    @branding = Branding.new
  end

  # GET /brandings/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /brandings
  def create
    @branding = Branding.new(branding_params)
    @branding.events_id = session[:current_event_id]
    @branding.save
    @events = Event.where(id: session[:current_event_id])
    @events.each do |event|
      @event = event
    end
    redirect_to @event
  end

  # PATCH/PUT /brandings/1
  def update
    @branding.update(branding_params)
    redirect_to session.delete(:return_to)
  end

  # DELETE /brandings/1
  def destroy
    @branding.destroy
    redirect_to session.delete(:return_to)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branding
      @branding = Branding.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branding_params
      params.require(:branding).permit(:btn_colour, :header, :logo)
    end
end
