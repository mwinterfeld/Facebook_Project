Feature: display signup page to create new Facebook account.
 
  As a prospective Facebook user,  
  so that I can create a new account, 
  I want to be able to sign up for a new Facebook account.

Scenario: sign up for Facebook account

  Given I am on the Facebook home page
  When I fill in first_name with Tom
  And I fill in last_name with Sawyer
  And I fill in username with tosa
  And I fill in password with 1234
  And I press Sign Up
  Then I should be on the Facebook home page
