class FavoritesController < ApplicationController
   before_action :authenticate_user!
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: tweet.id)
    favorite.save
    redirect_to tweet_path(tweet)
  end
  
  def destroy
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find(tweet_id: tweet_id)
    favorite.destroy
    redirect_to tweet_path(tweet)
  end
  
end
