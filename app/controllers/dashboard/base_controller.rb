class Dashboard::BaseController < ApplicationController
  before_action :require_user
  before_action :ensure_password

  def ensure_password
    return unless current_user
    # return unless current_user.email_verified_at
    return if current_user.password_digest.present?
    redirect_to password_reset_url(current_user.signed_id(expires_in: 10.minutes, purpose: "password_reset"))
  end
end
