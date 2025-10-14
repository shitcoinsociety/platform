require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "creating a deposit transaction updates user asset" do
    user = users(:admin)
    initial_asset = user.asset(:rst).amount

    user.deposits.create!(amount: 5000, symbol: "rst", description: "Test deposit")

    assert_equal initial_asset + 5000, user.asset(:rst).amount
  end

  test "creating a transfer transaction updates both user and sender assets" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    sender_initial_asset = sender.asset(:rst).amount
    receiver_initial_asset = receiver.asset(:rst).amount

    sender.send!(receiver, amount: 2000, symbol: "rst", description: "Test transfer")

    assert_equal sender_initial_asset - 2000, sender.asset(:rst).amount
    assert_equal receiver_initial_asset + 2000, receiver.asset(:rst).amount
  end

  test "transfer transaction fails if sender has insufficient asset" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    amount = sender.asset(:rst).amount + 1000

    assert_raises(ActiveRecord::RecordInvalid) do
      sender.send!(receiver, amount: amount, symbol: "rst", description: "Test transfer")
    end
  end
end
