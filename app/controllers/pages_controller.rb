class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @current_nav_identifier = :home
    @users = User.all
  end

  # GET /users
  def leaderboard
  #retreives all users for use in the leaderboard
    @users = User.all
  end

end


#class LeaderboardController < ApplicationController
#  def index
#    @users = User.all
#  end
#end
