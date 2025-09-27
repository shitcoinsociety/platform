require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "creating a deposit transaction updates user position" do
    user = users(:admin)
    initial_position = user.position_for(:rst).current

    user.deposits.create!(amount: 5000, symbol: "rst", description: "Test deposit")

    assert_equal initial_position + 5000, user.position_for(:rst).current
  end

  test "creating a transfer transaction updates both user and sender positions" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    sender_initial_position = sender.position_for(:rst).current
    receiver_initial_position = receiver.position_for(:rst).current

    sender.send!(receiver, amount: 2000, symbol: "rst", description: "Test transfer")

    assert_equal sender_initial_position - 2000, sender.position_for(:rst).current
    assert_equal receiver_initial_position + 2000, receiver.position_for(:rst).current
  end

  test "transfer transaction fails if sender has insufficient position" do
    sender = users(:admin)
    receiver = User.create!(email: "receiver@example.com", password: "password")

    amount = sender.position_for(:rst).current + 1000

    assert_raises(ActiveRecord::RecordInvalid) do
      sender.send!(receiver, amount: amount, symbol: "rst", description: "Test transfer")
    end
  end
end
