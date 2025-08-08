class Networks::Bitcoin
  def self.scan!
    Rails.logger.info "Scanning Bitcoin network for new transactions..."

    current_height = get_block_count
    last_height = Rails.cache.fetch("bitcoin_last_height", expires_in: 1.hour) do
      current_height - 1
    end

    if current_height <= last_height
      return Rails.logger.info "No new blocks found."
    end

    for height in (last_height + 1..current_height)
      process_block(height)
    end
  end

  def self.process_block(height)
    Rails.logger.info "Processing block ##{height}..."

    block_hash = call_rpc("getblockhash", [ height ])
    block = call_rpc("getblock", [ block_hash, 1 ])

    transactions = block["tx"] || []

    transactions.each do |tx|
      scan_transaction(tx)
    end
  end

  def self.scan_transaction(tx)
    tx["vout"].each_with_index do |output, index|
      address = output["scriptPubKey"]["addresses"]&.first
      value = output["value"]

      wallet = Wallet.for("btc").find_by(address: address)

      return unless wallet

      sats = (BigDecimal(value.to_s) * 100_000_000).to_i
      Transaction::Deposit.create!(
        user_id: wallet.user_id,
        amount: sats,
        symbol: "sat",
        gateway: "bitcoin",
        gateway_id: [ tx["txid"], index ].join(":")
      )
    end
  end

  def self.get_block_count
    call_rpc("getblockcount", [])
  end

  def self.call_rpc(method, params)
    url = ENV["BTC_RPC"]

    response = HTTParty.post(url,
      body: {
        jsonrpc: "2.0", method: method, params: params, id: 1
      }.to_json,
      headers: {
        "Content-Type" => "application/json"
      })
    if response.success?
      response.parsed_response["result"]
    else
      Rails.logger.info "Error calling RPC #{method}: #{response.parsed_response["error"]}"
      nil
    end
  end
end
