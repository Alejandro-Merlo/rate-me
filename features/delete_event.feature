Feature: As a speaker I want to delete events to take out them from the system

        Scenario: Successful removal of one event
          Given the user "Okuu" exists
          Given the "event 3" of "Okuu" exists for "2012/10/10"
          And I am in the user "Okuu" event list page
          When I press "Delete" 
          And I press "Yes"
          Then I should see "event was deleted"
