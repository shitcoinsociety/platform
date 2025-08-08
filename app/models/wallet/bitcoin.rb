class Wallet::Bitcoin < Wallet
  unless Rails.env.production?
    ::Bitcoin.chain_params = :testnet
  end

  XPUB = ENV["BTC_XPUB"]
  ROOT = XPUB && ::Bitcoin::ExtPubkey.from_base58(XPUB)

  def set_address
    return if self.address.present?
    # ROOT is m/84'/0'/0'
    self.address = ROOT.derive(0).derive(self.index).addr
  end
end
