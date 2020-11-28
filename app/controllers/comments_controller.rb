class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[destroy]

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = current_user.comments.new(comment_params)
    @comment.tweet_id = @tweet.id
    @comments = @tweet.comments
    @comment.save
      # flash[:success] = "コメントしました。"
      # redirect_to tweet_path(tweet)
    # else
      # flash[:danger] = "コメントを入力してください。"
      # redirect_to tweet_path(tweet)
    # end
  end

  def destroy
    @comment.destroy!
    # @tweet = Tweet.find(params[:tweet_id])
    # @comments = @tweet.comments
    # Comment.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
    # flash[:success] = "コメントを削除しました。"
    # redirect_to tweet_path(params[:tweet_id])
  end

  private
 
  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:tweet_comment)
  end
end
