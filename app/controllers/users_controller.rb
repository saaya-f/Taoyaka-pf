class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @tweet = Tweet.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.new
    @tweets = @user.tweets
  end

  def edit
  end
  
  def update
  end

  def out
  end
  
  def quit
  end
  
end
