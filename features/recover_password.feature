Feature: As a speaker I want to recover the password in case of forgetting it
  Email should be valid

        Background:
          Given the user "Pedrito" with email "machodelsur2012@gmail.com" exists
          And I am on recover pass page

        Scenario: Successful recovering of the password
          When I fill in "email" with "machodelsur2012@gmail.com"
          And I press "Send pass"
          Then I should see "Your password was sent"

        Scenario: Incorrect email
          When I fill in "email" with "noexiste@shimeil.com"
          And I press "Send pass"
          Then I should see "email is invalid"
