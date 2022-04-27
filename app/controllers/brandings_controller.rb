class BrandingsController < ApplicationController
  before_action :set_branding, only: [:show, :edit, :update, :destroy]
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
    @event = Event.where(id: session[:current_event_id]).first
  end

  # POST /brandings
  def create
    @branding = Branding.new(branding_params)
    @branding.events_id = session[:current_event_id]
    @branding.save
    @event = Event.where(id: session[:current_event_id]).first
    redirect_to @event
  end

  # PATCH/PUT /brandings/1
  def update
    @branding.update(branding_params)
    @event = Event.where(id: session[:current_event_id]).first
    if session[:new_event] == 0
      redirect_to edit_event_path(@event)
    elsif session[:new_event] == 1
      redirect_to @event
    end
  end

  # DELETE /brandings/1
  def destroy
    @branding.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branding
      @branding = Branding.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branding_params
      params.require(:branding).permit(:id, :header, :logo)
    end
end
