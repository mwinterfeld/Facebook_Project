Feature: 
 
 As a user,
 So that I can change my user info
 I want to have a page to edit/add info  

Scenario: change my user interests

  Given my username is 'jira' 
  And I am on jira's profile page 
  When I press "Edit Profile"
  Then I should be on the edit profile page
  When I fill in "interests" with "dogs"
  And I press "submit"
  Then I should be on my profile page
  And the "interests" field within "profile_info" should contain "dogs"
