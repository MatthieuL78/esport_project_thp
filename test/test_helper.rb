ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  options = Selenium::WebDriver::Chrome::Options.new
  chrome_bin_path = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  options.binary = chrome_bin_path if chrome_bin_path # only use custom path on heroku
  options.add_argument('--headless') # this may be optional
  driver = Selenium::WebDriver.for :chrome, options: options
  driver.navigate.to "https://stackoverflow.com"
end
