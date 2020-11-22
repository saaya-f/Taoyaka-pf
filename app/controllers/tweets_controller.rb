class TweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweet = Tweet.new
    @tweets = Tweet.page(params[:page]).per(2)
    @user = current_user
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweets = Tweet.page(params[:page]).per(2)
    @tweet.user_id = current_user.id
    @user = current_user
    if @tweet.save
      flash[:success] = "投稿しました。"
      redirect_to tweet_path(@tweet)
    else
      flash.now[:danger] = "内容を入力してください。"
      render :index
    end
  end

  def show
    @tweet_new = Tweet.new
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comment = Comment.new
    @comments = @tweet.comments.page(params[:page]).per(2)
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      flash[:success] = "編集内容を保存しました。"
      redirect_to tweet_path(tweet.id)
    else
      @tweet = tweet
      flash.now[:danger] = "編集内容を入力してください。"
      render :edit
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:success] = "投稿内容を削除しました。"
    redirect_to tweets_path
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :body)
  end
end
