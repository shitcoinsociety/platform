require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "creating a deposit transaction updates user account" do
    user = users(:admin)
    initial_balance = user.account(:rst).balance

    user.deposits.create!(amount: 5000, symbol: "rst", description: "Test deposit")

    assert_equal initial_balance + 5000, user.account(:rst).balance
  end

  test "creating a transfer transaction updates both user and sender accounts" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    sender_initial_balance = sender.account(:rst).balance
    receiver_initial_balance = receiver.account(:rst).balance

    sender.send!(receiver, amount: 2000, symbol: "rst", description: "Test transfer")

    assert_equal sender_initial_balance - 2000, sender.account(:rst).balance
    assert_equal receiver_initial_balance + 2000, receiver.account(:rst).balance
  end

  test "transfer transaction fails if sender has insufficient account balance" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    amount = sender.account(:rst).balance + 1000

    assert_raises(ActiveRecord::RecordInvalid) do
      sender.send!(receiver, amount: amount, symbol: "rst", description: "Test transfer")
    end
  end
end
