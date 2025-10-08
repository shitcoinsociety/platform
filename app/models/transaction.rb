class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User", optional: true

  validates :type, presence: true
  validates :amount, presence: true
  validates :symbol, presence: true

  after_create :update_positions
  after_create_commit :broadcast

  private

  def broadcast
    UserChannel[user].state("transactions").push(self.as_json)
  end

  def update_positions
    position = user.position_for(symbol)
    position.current += amount
    position.save!

    if sender
      sender_position = sender.position_for(symbol)
      sender_position.current -= amount
      sender_position.save!
    end
  end
end
