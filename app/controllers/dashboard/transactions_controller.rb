class Dashboard::TransactionsController < Dashboard::BaseController
  def index
    @total_earnings = 0
    @from_dividends = 0
    @from_commissions = 0
  end
end
