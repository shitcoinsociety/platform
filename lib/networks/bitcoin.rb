class Networks::Bitcoin
  def self.scan!
    Rails.logger.info "Scanning Bitcoin network for new transactions..."

    current_height = get_block_count
    if current_height.nil?
      return Rails.logger.info "Bitcoin RPC getblockcount failed."
    end

    last_height = Rails.cache.fetch("bitcoin_last_height") do
      current_height - 1
    end

    if current_height <= last_height
      return Rails.logger.info "No new blocks found."
    end

    (last_height + 1).upto(current_height) do |height|
      begin
        process_block(height)
        Rails.cache.write("bitcoin_last_height", height)
      rescue => e
        Rails.logger.info "Error processing block ##{height}: #{e.class} - #{e.message}"
      end
    end
  end

  def self.process_block(height)
    Rails.logger.info "Processing block ##{height}..."

    block_hash = call_rpc("getblockhash", [ height ])
    # Fetch full transaction details (verbosity 2)
    block = call_rpc("getblock", [ block_hash, 2 ])
    return unless block

    transactions = block["tx"] || []

    transactions.each do |tx|
      scan_transaction(tx)
    end
  end

  def self.scan_transaction(tx)
    Array(tx["vout"]).each_with_index do |output, index|
      spk = output["scriptPubKey"] || {}
      address = spk["address"] || spk["addresses"]&.first
      value = output["value"]

      next unless address

      wallet = Wallet.for("bitcoin").find_by(address: address)
      next unless wallet

      sats = (BigDecimal(value.to_s) * 100_000_000).to_i
      network_id = [ tx["txid"], index ].join(":")

      Transaction::Deposit.find_or_create_by!(network: "bitcoin", network_id: network_id) do |dep|
        dep.user_id = wallet.user_id
        dep.amount = sats
        dep.symbol = "sat"
      end
    end
  end

  def self.get_block_count
    call_rpc("getblockcount", [])
  end

  def self.call_rpc(method, params)
    url = ENV["BTC_RPC"]

    begin
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
        err = (response.parsed_response["error"] rescue response.body)
        Rails.logger.info "Error calling RPC #{method}: #{err}"
        nil
      end
    rescue => e
      Rails.logger.info "RPC request failed for #{method}: #{e.class} - #{e.message}"
      nil
    end
  end
end
