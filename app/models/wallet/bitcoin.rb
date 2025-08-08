class Wallet::Bitcoin < Wallet
  unless Rails.env.production?
    ::Bitcoin.chain_params = :testnet
  end

  ROOT = ::Bitcoin::ExtPubkey.from_base58(ENV["BTC_XPUB"])

  def set_address
    # ROOT is at m/84'/0'/0'
    self.address = ROOT.derive(0).derive(self.index).addr
  end
end
