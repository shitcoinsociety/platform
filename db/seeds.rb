unless Rails.env.production?
  coupon = Coupon.find_or_create_by!(code: "EXAMPLECODE") do |coupon|
    coupon.amount = 1000
  end
  coupon.update(redeemed_by_id: nil)
end
