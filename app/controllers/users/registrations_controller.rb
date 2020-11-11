class Users::RegistrationsController < ApplicationController
  before_action :check_guest, only: [:update, :destroy]
  
  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません'
    end
  end
end
