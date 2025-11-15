class User < ApplicationRecord
  JSON_OPTIONS = {
    only: %i[id email ref_code]
  }

  has_secure_password

  has_many :accounts
  has_many :transactions, foreign_key: :receiver_id
  has_many :deposits, class_name: "Transaction::Deposit", foreign_key: :receiver_id

  has_many :referrals, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referrer, class_name: "User", optional: true

  before_create :generate_ref_code

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def account(symbol)
    accounts.where(symbol: symbol).first_or_create
  end

  def send!(receiver, amount:, symbol:, description: nil)
    Transaction::Transfer.create!(
      receiver: receiver,
      sender: self,
      amount: amount,
      symbol: symbol,
      description: description
    )
  end

  private
  def generate_ref_code
    begin
      self.ref_code = SecureRandom.alphanumeric(5).upcase
    end while User.exists?(ref_code: ref_code)
  end
end
