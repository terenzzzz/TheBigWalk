class LinkersController < ApplicationController
  before_action :set_linker, only: [:show, :edit, :update, :destroy]

  # GET /linkers
  def index
    @linkers = Linker.all
  end

  # GET /linkers/1
  def show
  end

  # GET /linkers/new
  def new
    @linker = Linker.new
  end

  # GET /linkers/1/edit
  def edit
  end

  # POST /linkers
  def create
    @linker = Linker.new(linker_params)

    if @linker.save
      redirect_to @linker, notice: 'Linker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /linkers/1
  def update
    if @linker.update(linker_params)
      redirect_to @linker, notice: 'Linker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /linkers/1
  def destroy
    @linker.destroy
    redirect_to linkers_url, notice: 'Linker was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linker
      @linker = Linker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def linker_params
      params.require(:linker).permit(:distance_from_start, :checkpoint_description, :advised_time)
    end
end
