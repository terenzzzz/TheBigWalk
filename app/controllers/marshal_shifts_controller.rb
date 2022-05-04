class MarshalShiftsController < ApplicationController
    before_action :set_marshal_shift, only: [:show, :edit, :update, :destroy]
  
    def index
    end
  
    def show
    end
  
    def new
      @marshal_shift = MarshalShift.new
    end
  
    def edit
    end
  
    def update
    end

    def destroy
    end
