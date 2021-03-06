Feature: As a speaker I want to see a list of my events

	Scenario: Successful access to event list
          Given the user "Juan" exists 
	  And the "event 1" of "Juan" exists for "2012/10/10"
	  And the "event 2" of "Juan" exists for "2012/10/11"
	  And I am in the user "Juan" event list page
	  Then I should see "event 1"
	  Then I should see "event 2"
