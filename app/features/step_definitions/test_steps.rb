Given(/^I am on the website$/) do
  @abstract_page = AbstractPage.new
  @abstract_page.load
end

When(/^I click 'Войти' link to open login page$/) do
  @abstract_page = AbstractPage.new
  @abstract_page.wait_for_enter_to_login(10)
  print 123.class
  @abstract_page.enter_to_login.click
end

When(/^I type in 'Пользователь' field with name "([^"]*)"$/) do |arg|
  @abstract_page = AbstractPage.new
  @abstract_page.wait_for_username_field(10)
  @abstract_page.username_field.set(arg)
end

And(/^I type in 'Пароль' field with "([^"]*)"$/) do |arg|
  @abstract_page = AbstractPage.new
  @abstract_page.wait_for_password_field(10)
  @abstract_page.password_field.set(arg)
end

When(/^I click submit button$/) do
  @abstract_page = AbstractPage.new
  @abstract_page.wait_for_submit_button(10)
  @abstract_page.submit_button.click
end

Then(/^I verify that login unsuccessfull$/) do
  page.should have_content('Invalid user or password')
end

