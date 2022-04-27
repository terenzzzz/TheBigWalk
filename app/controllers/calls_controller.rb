class CallsController < ApplicationController
  before_action :set_linker, only: [:show, :edit, :update, :destroy]

  # GET /linkers
  def index
  end

  # GET /linkers/1
  def show
  end

  # GET /linkers/new
  def new
  end

  # GET /linkers/1/edit
  def edit
  end

  # POST /linkers
  def create
  end

  # PATCH/PUT /linkers/1
  def update
  end

  # DELETE /linkers/1
  def destroy
    @call.destroy
    redirect_to view_calls_admins_path, notice: 'Call request was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linker
      @call = Call.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def linker_params
      params.require(:routes_and_checkpoints_linker).permit(:distance_from_start, :checkpoint_description, :advised_time)
    end
end
