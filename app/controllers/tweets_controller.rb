class TweetsController < ApplicationController
  # before_action :authenticate_user!
  
  def index
    @tweet = Tweet.new
  end
  
  def create
    @tweet =Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweet_path(@tweet.id)
  end

  def edit
  end

  def show
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :body)
  end
end
