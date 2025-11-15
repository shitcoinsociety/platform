class Transaction < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User", optional: true

  validates :type, presence: true
  validates :amount, presence: true
  validates :symbol, presence: true

  after_create :update_balances
  after_create_commit :broadcast

  private

  def broadcast
    UserChannel[receiver].state("transactions").push(self.as_json)
  end

  def update_balances
    if receiver
      receiver_account = receiver.account(symbol)
      receiver_account.balance += amount
      receiver_account.save!
    end
    if sender
      sender_account = sender.account(symbol)
      sender_account.balance -= amount
      sender_account.save!
    end
  end
end
