class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User", optional: true

  validates :type, presence: true
  validates :amount, presence: true
  validates :symbol, presence: true

  after_create :update_assets
  after_create_commit :broadcast

  private

  def broadcast
    UserChannel[user].state("transactions").push(self.as_json)
  end

  def update_assets
    asset = user.asset(symbol)
    asset.amount += amount
    asset.save!

    if sender
      sender_asset = sender.asset(symbol)
      sender_asset.amount -= amount
      sender_asset.save!
    end
  end
end
