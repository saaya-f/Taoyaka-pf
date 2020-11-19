class Users::SessionsController < Devise::SessionsController
  
  def new_guest
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to user_path(user)
  end
  
  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:danger] = "退会済みです"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "必須項目を入力してください"
    end
  end
  
end
