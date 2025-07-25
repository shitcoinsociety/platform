require "application_system_test_case"

class SignupTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
  include Capybara::Email::DSL

  test "sign up, wrong password, password reset" do
    visit "/"

    fill_in "email", with: "derp@derp.com"
    click_on "Start Your Journey"
    click_on "Continue"

    within(".modal") do
      fill_in "password", with: "Derpsi2"
      click_on "Save password"
      click_on "Go to Dashboard"
    end

    # email verification not yet implemented
    User.last.update! email_verified_at: Time.current

    click_on "Log out"
    assert_text "You have been logged out"

    click_on "Log in"

    # try wrong password
    within(".modal") do
      fill_in "email", with: "derp@derp.com"
      fill_in "password", with: "wrongpassword"
      click_on "Log in"
    end

    assert_text "Invalid email or password"

    within(".modal") do
      click_on "Forgot your password?"
      fill_in "email", with: "derp@derp.com"
      click_on "Request new password"
      assert_text "Check your email"
    end

    perform_enqueued_jobs

    open_email("derp@derp.com")
    current_email.first(:link).click

    within(".modal") do
      assert_text "Set a new password"
      fill_in "password", with: "Derpsi3"
      click_on "Save password"
      assert_text "Password saved"
      click_on "Log in"

      fill_in "email", with: "derp@derp.com"
      fill_in "password", with: "Derpsi3"
      click_on "Log in"
    end

    assert_text "You have been logged in"
  end
end
