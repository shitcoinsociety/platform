class User < ApplicationRecord
  has_secure_password

  has_many :balances

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }


  def balance_for(symbol)
    balances.first_or_create(symbol: symbol)
  end
end
