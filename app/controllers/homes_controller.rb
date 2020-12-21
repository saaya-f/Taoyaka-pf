class HomesController < ApplicationController
  LIMIT = 4
  def top
    @tweets = Tweet.page(params[:page]).per(LIMIT).order(created_at: :desc)
  end
end
