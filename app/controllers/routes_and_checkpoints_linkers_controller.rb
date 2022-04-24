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
    #@checkpoint = Checkpoint.where(id: @linker.checkpoint_id).first
    #@route = Route.where(id: @linker.route_id).first
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
    if @linker.update(linker_params)
      linkers = RoutesAndCheckpointsLinker.where(route_id: @linker.route_id)
      ordered_linkers = [linkers.first]
      count = 0

      #creates a list of ordered linkers based on distance from start
      linkers.drop(1).each do |linker|
        ordered_linkers.each do |ordered|
          if ordered.distance_from_start > linker.distance_from_start
            ordered_linkers.insert(count, linker)
            count = 0
            break
          elsif (count + 1) == ordered_linkers.length()
            ordered_linkers.push(linker)
            count = 0
            break
          end
          count = count + 1
        end
      end

      #checks if the current position is the correct one then moves any incorrect ones
      count = 1
      ordered_linkers.each do |linker|
        if count != linker.position_in_route
          linker.position_in_route = count
          linker.save
        end
        count = count + 1
      end

      spreadsheet = Spreadsheet.new
      spreadsheet.add_checkpoint((Route.where(id: @linker.route_id).first), (Checkpoint.where(id: @linker.checkpoint_id).first))

      #check if there are any more linkers to update after
      session[:linker_route_ids_index] = session[:linker_route_ids_index] + 1
      if session[:linker_route_ids_index] == session[:linker_route_ids].length()
        redirect_to checkpoints_path
      else
        #redirects to next linker
        @route_id = session[:linker_route_ids].at(session[:linker_route_ids_index])
        @route = RoutesAndCheckpointsLinker.where(checkpoint_id: session[:linker_check_id], route_id: @route_id).first
        redirect_to edit_routes_and_checkpoints_linker_path(@route)
      end
    else
      render :edit
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
