class Dashboard::WalletsController < Dashboard::BaseController
  def show
    symbol = params[:id]
    wallet = current_user.wallets.for(symbol).first_or_create
    @wallet = wallet.as_json(Wallet::JSON_OPTIONS)
  end
end
