class Users::SessionsController < ApplicationController
  def new_guest
    user = User.guest
    sign_in user
    redirect_to user_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
