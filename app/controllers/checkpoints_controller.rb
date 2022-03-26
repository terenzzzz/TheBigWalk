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
    
    session[:return_to] ||= request.referer
  end

  # GET /checkpoints/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /checkpoints
  def create
    @checkpoint = Checkpoint.new(checkpoint_params)
    @checkpoint.events_id = session[:current_event_id]
    @checkpoint.save 
    redirect_to session.delete(:return_to)
  end

  # PATCH/PUT /checkpoints/1
  def update
    @checkpoint.update(checkpoint_params)
    redirect_to session.delete(:return_to)
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
      params.require(:checkpoint).permit(:name, :distance, :location, :advisedTime, :description)
    end
end
