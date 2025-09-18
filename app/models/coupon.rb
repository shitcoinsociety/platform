class Coupon < ApplicationRecord
  def redeem!(user)
    self.redeemed_by_id = user.id
    self.save!

    balance = user.balance_for(:rst)
    balance.current += self.amount
    balance.save!
  end
end
