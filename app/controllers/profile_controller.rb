class ProfileController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def account
    end
    

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(current_user.id)
    end
    
    end