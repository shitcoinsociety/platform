require "application_system_test_case"

class ReferralsTest < ApplicationSystemTestCase
  test "user can create a referral" do
    visit new_user_path

    assert_text "Sign Up"

    within("main") do
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_on "Sign Up"
    end

    assert_text "logged in"

    assert_text "Total referrals: 0"

    invite_link = find(".invite_link").text

    click_on "Log out"
    assert_text "logged out"

    visit invite_link

    within("main") do
      fill_in "Email", with: "referral@example.com"
      fill_in "Password", with: "password"
      click_on "Sign Up"
    end

    assert_text "logged in"

    click_on "Log out"

    click_on "Log in"

    within("main") do
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_on "Log In"
    end

    assert_text "Total referrals: 1"
  end
end
