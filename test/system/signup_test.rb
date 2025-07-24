require "application_system_test_case"
class SignupTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "can sign up" do
    visit "/"

    fill_in "email", with: "derp@derp.com"
    click_on "Start Your Journey"
    click_on "Continue"


    fill_in "password", with: "Derpsi2"
    click_on "Save password"
    click_on "Go to Dashboard"

    click_on "Log out"

    assert_text "You have been logged out"
  end
end
