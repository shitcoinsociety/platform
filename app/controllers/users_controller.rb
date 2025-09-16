class UsersController < ApplicationController
  wrap_parameters :user, include: %i[email password]

  before_action :require_user, only: [ :show ]

  def new
  end

  def show
    @balance = current_user.balance_for(:sat).current
  end

  def create
    user = User.create!(create_params)
    session[:user_id] = user.id
    flash[:notice] = "You have been logged in!"
    redirect_to root_path
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
