class AdminsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def show
    end

    def view_marshals 
        @marshals = Marshall.all
        @users = Array.new
        @marshals.each do |marshal|
            @user = [User.where(id: marshal.users_id).first, Checkpoint.where(id: marshal.checkpoints_id).first] 
            @users.push(@user)
        end
        
        #build 2d array with marshals name and checkpoint 

    end
end
