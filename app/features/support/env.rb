require 'selenium-webdriver'
require 'cucumber'
require 'capybara/cucumber'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'site_prism'
require 'capybara-screenshot'
require 'capybara-webkit'
require 'rspec'
require 'capybara-screenshot/rspec'
require 'capybara-screenshot/cucumber'
require 'headless'
require 'reportportal'

$feature_name = 'screenshot'

include RSpec::Matchers

RSpec.configure do |config|
  config.include Capybara::DSL
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end



# # ---------Browser------------------
#
# Capybara.configure  do |capybara|
#   # $timeout = 1000
#   Capybara.default_max_wait_time = 0
#
#   #
#   Capybara.register_driver :selenium_ff do |app|
#
#     client = Selenium::WebDriver::Remote::Http::Default.new
#     client.timeout = 600
#
#     Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client,
#                                    desired_capabilities: {
#                                        "ffOptions" => {
#                                            "args" => %w{ window-size=1580,1024 }
#                                        }
#                                    }
#     )
#   end
#
#   Capybara.register_driver :selenium_ie do |app|
#     Capybara::Selenium::Driver.new(app, :browser => :ie)
#   end
#
#
#   Capybara.register_driver :selenium_chrome do |app|
#
#     client = Selenium::WebDriver::Remote::Http::Default.new
#     client.timeout = 600
#
#     Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => client,
#                                    desired_capabilities: {
#                                        "chromeOptions" => {
#                                            "args" => %w{ window-size=1580,1024 }
#                                        }
#                                    }
#     )
#   end
#
#   capybara.default_driver = :selenium_chrome
#   capybara.run_server = false
#
#   After do |scenario|
#     if(scenario.failed?)
#       t = Time.now
#       page.driver.browser.save_screenshot("reports/#{$feature_name}.png")
#       embed("#{$feature_name}.png", "image/png", "SCREENSHOT")
#       puts "reports/#{$feature_name}_#{t.strftime('%H-%M-%S')}.png"
#     end
#   end
#
# end


headless = Headless.new
headless.start

# --------Headless------------
Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 0
Capybara.ignore_hidden_elements = true
Capybara.visible_text_only = true

# Capybara.match = :smart
Capybara.automatic_reload = false

Capybara::Webkit.configure do |config|
  config.debug = false
  config.timeout = 600
  # config.block_unknown_urls
  config.allow_unknown_urls
  # config.default_selector = :xpath
  # config.run_server = false
  # config.match = :smart
  # config.exact_options = false
  # config.visible_text_only = true
  # config.skip_image_loading
  # config.timeout = 1
  # config.debug = true
end

#------------capybara-webkit screenshots---------------
Capybara.save_path = File.expand_path("../../reports", __FILE__)
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = true
Capybara::Screenshot.append_timestamp = true

Capybara::Screenshot.class_eval do
  register_filename_prefix_formatter(:default) do
    "#{$feature_name}"
  end
end

Capybara::Screenshot.webkit_options = {width: 1920, height: 1080}








