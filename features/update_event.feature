Feature: As the speaker I want to update an event details in case of exist a change
  Date field content should be a valid date format

        Background:
          Given the user "Juancito" exists
          And the "talk about something" of "Juancito" exists for "2012-11-26"
          And I am in the event "talk about something" edit event page

        Scenario: Successful updating of an event details
          When I fill in "name" with "talk about everything"
          And I fill in "date" with "2012-12-26"
          And I press "Edit event"
          Then I should see "event details were updated"


        Scenario: Invalid date
          When I fill in "name" with "talk about everything"
          And I fill in "date" with "i'm not still a date"
          When I press "Edit event"
          Then I should see "invalid date"
