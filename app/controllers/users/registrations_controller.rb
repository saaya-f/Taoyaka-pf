class Users::RegistrationsController < Devise::RegistrationsController
  
  def new_guest
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to user_path(user)
  end
end
