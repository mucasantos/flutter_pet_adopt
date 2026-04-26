Feature: Login
  As a client
  I want to login
  So that I can access my account
  And manage my pets

  Scenario: Login with valid credentials
    Given the user is on the login page
    When the user enters the email and password
    Then the user should be redirected to the home page
    And keep user logged in

  Scenario: Login with invalid credentials
    Given the user is on the login page
    When the user enters the email and password
    Then the user should not be redirected to the home page
    And the user should see an error message
