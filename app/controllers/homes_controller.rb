class HomesController < ApplicationController

  def top
    @tweets = Tweet.page(params[:page]).per(4).order(created_at: :desc)
  end
  
  def signed_in?
    
  end
end
