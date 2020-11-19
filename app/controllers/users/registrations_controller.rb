class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :update
  
  def new_guest
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to user_path(user)
  end
  
  def check_guest
    if resource.email == 'guest_uuu@example.com'
      flash[:danger] = 'ゲストユーザーは削除できません。'
      redirect_to root_path
    end
  end
end
