user = User.find_or_create_by!(id: 1) do |user|
  user.email = "admin@shitcoinsociety.com"
  user.password = "Hunter2"
end

user.deposits.find_or_create_by!(amount: 420_000_000, symbol: "rst")

unless Rails.env.production?
  coupon = Coupon.find_or_create_by!(code: "EXAMPLECODE") do |coupon|
    coupon.amount = 1000
  end
  coupon.update(redeemed_by_id: nil)
end
