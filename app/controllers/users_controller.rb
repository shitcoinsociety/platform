class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.create!(create_params)

    session[:user_id] = @user.id
    redirect_to dashboard_root_path
  end

  private

  def create_params
    params.require(:user).permit(:email)
  end
end
