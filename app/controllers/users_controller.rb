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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  # 退会画面
  def out
    @user = User.find(current_user.id)
  end
  
  # 退会機能
  def quit
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :age, :work, :introduction)
  end
  
end
