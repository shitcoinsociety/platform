require "test_helper"

class NetworksBitcoinTest < ActiveSupport::TestCase
  test "creates a deposit transaction when scanning a block with an output to a user's wallet" do
    user = User.create!(email: "user@example.com", password: "password")

    # Create wallet with a fixed address (no xpub needed)
    test_address = "tb1qdeposittestaddress0000000000000000000000000"
    Wallet::Bitcoin.create!(user: user, address: test_address, index: 0)

    # Ensure we start with no cached last height
    Rails.cache.delete("bitcoin_last_height")

    # Stub RPC responses for one new block containing a tx paying to the wallet
    rpc = ->(method, params) do
      case method
      when "getblockcount"
        100
      when "getblockhash"
        "0000000000000000000testblockhash"
      when "getblock"
        {
          "tx" => [
            {
              "txid" => "testtxid123",
              "vout" => [
                { "value" => 0.015, "n" => 0, "scriptPubKey" => { "addresses" => [ test_address ] } },
                { "value" => 0.5, "n" => 1, "scriptPubKey" => { "addresses" => [ "tb1qsomethingelse00000000000000000000000000" ] } }
              ]
            }
          ]
        }
      else
        flunk "Unexpected RPC method: #{method} with params #{params.inspect}"
      end
    end

    # Temporarily replace Networks::Bitcoin.call_rpc
    Networks::Bitcoin.stub(:call_rpc, rpc) do
      assert_difference -> { Transaction::Deposit.count }, +1 do
        Networks::Bitcoin.scan!
      end
    end

    deposit = Transaction::Deposit.last
    assert_equal user.id, deposit.user_id
    assert_equal "sat", deposit.symbol
    assert_equal 1_500_000, deposit.amount.to_i
    assert_equal "bitcoin", deposit.network
    assert_equal "testtxid123:0", deposit.network_id
  end
end
