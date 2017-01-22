class AbstractPage < SitePrism::Page

  set_url "http://demo.redmine.org/"

  element :enter_to_login, :xpath, "//a[@class='login']"
  element :username_field, :xpath, "//input[@id='username']"
  element :password_field, :xpath,  "//input[@id='password']"
  element :submit_button, :xpath,  "//input[@type='submit']"

end