class User < ApplicationRecord
  JSON_OPTIONS = {
    only: %i[id email ref_code]
  }

  has_secure_password

  has_many :balances
  has_many :referrals, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referrer, class_name: "User", optional: true

  before_create :generate_ref_code

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def balance_for(symbol)
    balances.first_or_create(symbol: symbol)
  end

  private
  def generate_ref_code
    begin
      self.ref_code = SecureRandom.alphanumeric(5).upcase
    end while User.exists?(ref_code: ref_code)
  end
end
