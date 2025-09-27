require "application_system_test_case"

class CodeRedemptionsTest < ApplicationSystemTestCase
  test "logged in user can redeem a code" do
    admin = User.find(1)

    assert_equal admin.balance_for(:rst).current, 420_000_000

    visit "/"
    click_on "Redeem Code"

    assert_text "You must be logged in"

    within("main") do
      fill_in "Email", with: "new@example.com"
      fill_in "Password", with: "password"
      click_on "Sign Up"
    end

    assert_text "logged in"

    click_on "Redeem Code"

    within("main") do
      fill_in "XXX", with: "EXAMPLECODE"
      click_on "Redeem"
    end

    assert_text "Code redeemed successfully"

    assert_equal admin.reload.balance_for(:rst).current, 419_999_000

    assert_text "RST: 1000"

    click_on "Redeem Code"

    within("main") do
      fill_in "XXX", with: "EXAMPLECODE"
      click_on "Redeem"
    end

    assert_text "Code has already been redeemed"
  end
end
