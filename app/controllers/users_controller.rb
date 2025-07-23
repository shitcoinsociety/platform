class UsersController < ApplicationController
  def new
    @email = params[:email]
  end

  def create
    user = User.create!(create_params)

    session[:user_id] = user.id
  end

  private

  def create_params
    params.require(:user).permit(:email)
  end
end
