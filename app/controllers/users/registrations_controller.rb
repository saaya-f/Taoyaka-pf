class Users::RegistrationsController < ApplicationController
  # before_action :check_guest, only: :destroy
  
  def new_guest
    user = User.guest
    sign_in user
    redirect_to user_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません'
    end
  end
end
