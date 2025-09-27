class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User", optional: true

  validates :type, presence: true
  validates :amount, presence: true
  validates :symbol, presence: true

  after_create :update_balances

  private

  def update_balances
    balance = user.balance_for(symbol)
    balance.current += amount
    balance.save!

    if sender
      sender_balance = sender.balance_for(symbol)
      sender_balance.current -= amount
      sender_balance.save!
    end
  end
end
