class Dashboard::ReferralsController < Dashboard::BaseController
  before_action :show_in_modal, only: [ :new ]

  def index
    @total_earnings = 0
    @from_dividends = 0
    @from_commissions = 0
  end

  def create
    email = params[:email]
    link = root_url(ref: current_user.referral_code)
    UserMailer.with(user: current_user, email: email, link: link).invite.deliver_later
    redirect_back notice: "Invitation sent to #{email}."
  end

  def new
  end
end
