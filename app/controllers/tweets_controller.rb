class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
    @user = current_user
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweets = Tweet.all
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path
    else
      render :index
    end
  end

  def show
    @tweet = Tweet.new
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comment = Comment.new
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to tweet_path(tweet.id)
    else
      @tweet = tweet
      render :edit
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :body)
  end
end
