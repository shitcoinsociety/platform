class User < ApplicationRecord
  PRIVATE_JSON_OPTIONS = {
    only: [ :id, :email, :email_verified_at, :referral_code ]
  }

  has_secure_password validations: false
  has_secure_token :email_verification_token

  belongs_to :referrer, class_name: "User", optional: true
  has_many :referrals, -> { verified }, class_name: "User", foreign_key: "referrer_id"

  has_many :wallets
  has_many :transactions

  scope :verified, -> { where.not(email_verified_at: nil) }

  validates :email,
    presence: true,
    length: { maximum: 50 },
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: {
      case_sensitive: false
    }

  before_create :generate_referral_code

  def generate_referral_code
    loop do
      self.referral_code = SecureRandom.base36(6).upcase
      break unless User.exists?(referral_code: referral_code)
    end
  end
end
