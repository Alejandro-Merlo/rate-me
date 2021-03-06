Feature: As a speaker I want to sign in to login
  Username should be unique

	Scenario: Successful registration at the site
          Given the user "Daniel" doesn't exist
	  Given I am on registration page
	  When I fill in "username" with "Daniel"
	  And I fill in "password" with "abc1234"
	  And I fill in "email" with "machodelsur88@amail.com"
	  When I press "Register"
	  Then I should see "account was created"


	Scenario: Existent username
	  Given the user "Alejandro" exists
	  And I am on registration page
	  When I fill in "username" with "Alejandro"
	  And I fill in "password" with "abc1234"
	  And I fill in "email" with "machodelsur88@amail.com"
	  When I press "Register"
	  Then I should see "username already exists"
