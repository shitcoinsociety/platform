class Dashboard::WalletsController < Dashboard::BaseController
  def show
    network = params[:id]
    wallet = current_user.wallets.for(network).first_or_create
    @wallet = wallet.as_json(Wallet::JSON_OPTIONS)
  end
end
