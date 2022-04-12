class RoutesAndCheckpointsLinkersController < ApplicationController
  before_action :set_linker, only: [:show, :edit, :update, :destroy]

  # GET /linkers
  def index
    @linkers = RoutesAndCheckpointsLinker.all
  end

  # GET /linkers/1
  def show
  end

  # GET /linkers/new
  def new
    @linker = RoutesAndCheckpointsLinker.new
  end

  # GET /linkers/1/edit
  def edit
  end

  # POST /linkers
  def create
    @linker = RoutesAndCheckpointsLinker.new(linker_params)

    if @linker.save
      redirect_to @linker, notice: 'Linker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /linkers/1
  def update
    @linker.update(linker_params)
    session[:linker_route_ids_index] = session[:linker_route_ids_index] + 1
    #puts session[:linker_route_ids_index]
    #puts
    if session[:linker_route_ids_index] == session[:linker_route_ids].length()
      redirect_to session.delete(:return_to)
      #redirect_to @linker
    else
      @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
      @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id)
      @route.each do |route|
        redirect_to edit_routes_and_checkpoints_linker_path(route)
      end
    end
  end

  # DELETE /linkers/1
  def destroy
    @linker.destroy
    redirect_to routes_and_checkpoints_linkers_url, notice: 'Linker was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linker
      @linker = RoutesAndCheckpointsLinker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def linker_params
      params.require(:routes_and_checkpoints_linker).permit(:distance_from_start, :checkpoint_description, :advised_time)
    end
end
