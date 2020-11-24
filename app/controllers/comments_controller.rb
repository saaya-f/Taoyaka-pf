class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = current_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    if comment.save
      flash[:success] = "コメントしました。"
      redirect_to tweet_path(tweet)
    else
      flash[:danger] = "コメントを入力してください。"
      redirect_to tweet_path(tweet)
    end
  end

  def destroy
    Comment.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to tweet_path(params[:tweet_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:tweet_comment)
  end
end
