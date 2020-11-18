class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @tweet = Tweet.new
    @users = User.page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.new
    @tweets = @user.tweets.page(params[:page]).per(2)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "編集内容を変更しました。"
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "必須項目を入力してください。"
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
    flash[:success] = "ご利用ありがとうございました。またのご利用をお待ちしてます。"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image, :name, :email, :age, :work, :introduction)
  end
  
end
