require "test_helper"
require "capybara/cuprite"

Capybara.disable_animation = true
Capybara.configure do |config|
  config.test_id = "data-test"
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActiveJob::TestHelper

  options = ENV["GITHUB_WORKFLOW"] ? {
    headless: true,
    no_sandbox: true,
    disable_dev_shm_usage: true
  } : {
    headless: true
  }

  options.merge! js_errors: true

  driven_by :cuprite, using: :chromium, screen_size: [ 500, 900 ], options: options

  def fill_in(locator, with:, **options)
    sleep 0.1
    super(locator, with: with, **options)
  end

  def click_on(*args)
    sleep 0.1
    super
  end

  def log_in_as(user, password = "password")
    visit "/"
    click_on "Log in"

    fill_in "email", with: user.email
    fill_in "password", with: password

    click_on "login"
  end

  def log_out
    click_on "user"
    click_on "Log out"
  end
end
