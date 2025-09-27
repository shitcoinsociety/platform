class Coupon < ApplicationRecord
  def redeem!(user)
    raise "Coupon already redeemed" if redeemed_by_id.present?

    self.redeemed_by_id = user.id
    self.save!

    sender = User.find(1)
    sender.send!(user, amount: amount, symbol: :rst, description: "Redeemed coupon #{code}")
  end
end
