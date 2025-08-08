class Transaction < ApplicationRecord
  JSON_OPTIONS = {
    only: [ :id, :amount, :symbol, :type, :created_at ]
  }

  belongs_to :user

  validates :symbol, presence: true, inclusion: { in: %w[sat] }

  after_create :broadcast_to_user

  def broadcast_to_user
    UserChannel[user].state("transactions").push(self.as_json(JSON_OPTIONS))
  end
end
