class RedemptionsController < ApplicationController
  before_action :require_user

  def new
  end

  def create
    coupon = Coupon.find_by(code: params[:code])
    if coupon.nil?
      flash[:error] = "Invalid code"
      redirect_back
      return
    end

    if coupon.redeemed_by_id.present?
      flash[:error] = "Code has already been redeemed"
      redirect_back
      return
    end

    coupon.redeem!(current_user)

    flash[:notice] = "Code redeemed successfully"
    redirect_to root_path
  end
end
