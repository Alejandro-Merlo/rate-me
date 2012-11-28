Feature: As a speaker I want to create an event in order to receive feedback
  Date field content should be a valid date format

        Background:
          Given the user "Juan" exists
          And I am in the user "Juan" create event page

       Scenario: Successful creation of an event
          Given I fill in "name" with "talk about something"
          And I fill in "date" with "2012-10-13"
          When I press "Create event"
          Then I should see "Event created"


       Scenario: Invalid date
          Given I fill in "name" with "talk about something"
          And I fill in "date" with "i'm not a date"
          When I press "Create event"
          Then I should see "invalid date"
