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

include RSpec::Matchers

RSpec.configure do |config|
  config.include Capybara::DSL
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

headless = Headless.new(:dimensions => '1920x1080x24')
headless.start

Capybara.register_driver :firefox do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :firefox
Capybara.javascript_driver = :firefox

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

Capybara.save_path = File.expand_path("../../reports", __FILE__)
Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = true
Capybara::Screenshot.append_timestamp = true
Capybara::Screenshot.webkit_options = {width: 1920, height: 1080}

Capybara::Screenshot.register_driver(:firefox) do |driver, path|
  driver.browser.save_screenshot(path)
end

Before do
	  headless.video.start_capture
    Capybara.current_session.driver.browser.manage.window.resize_to(1920,1080)
end

After do |scenario|
  if scenario.failed?

    t = Time.now
    save_file_path = Capybara.save_path << '/' << scenario.name.split.join("_") << '-' << t.strftime("_%Y%d%m_%H%M%S")

    puts save_file_path

    headless.video.stop_and_save(save_file_path + '.mov')
    page.driver.browser.save_screenshot(save_file_path + '.png')

  else
    headless.video.stop_and_discard
  end
end
