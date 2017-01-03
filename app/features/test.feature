@test
Feature: Test Login function

  Scenario: Login unregistered user with valid credentials

    Given I am on the website
    When I click 'Войти' link to open login page
    When I type in 'Пользователь' field with name "user"
    And I type in 'Пароль' field with "1111"
    When I click submit button
    Then I verify that login unsuccessfull
