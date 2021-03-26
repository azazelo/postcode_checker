require 'rails_helper'
require 'selenium-webdriver'

RSpec.configure do |config|
  Capybara.default_max_wait_time = 8

#  config.include AcceptanceHelper, type: :feature
  options = {
    :window_size =>[1920, 6000],
    :inspector => true,
    js_errors: false
  }
  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      args: %w[headless disable-gpu no-sandbox],
      options: options
    )
    options.add_option('w3c',false)
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {'w3c' => true}
    )
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, desired_capabilities: capabilities)
  end
  
  config.use_transactional_fixtures = false
end

def show_page
  save_page Rails.root.join( 'public', 'capybara.html' )
  %x(launchy http://localhost:3000/capybara.html)
end
