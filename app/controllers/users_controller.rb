class UsersController < ApplicationController
  wrap_parameters :user, include: %i[email password]

  before_action :require_user, only: [ :show ]

  def new
  end

  def show
    @sat_balance = current_user.balance_for(:sat).current
    @rst_balance = current_user.balance_for(:rst).current
    @ref_count = current_user.referrals.count
  end

  def create
    user = User.create!(create_params)
    if session[:ref_code]
      user.referrer = User.find_by(ref_code: session[:ref_code])
      user.save!
      session[:ref_code] = nil
    end
    session[:user_id] = user.id
    flash[:notice] = "You have been logged in!"
    redirect_to root_path
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
end
