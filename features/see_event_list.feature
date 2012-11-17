Feature: As a speaker I want to see a list of my events

	Scenario: Not event event list
	  Given the "event 1" exists for "2012-10-10"
	  Given the "event 2" exists for "2012-10-11"
	  Given I am on event list page
	  Then I should see "event 1"
	  Then I should see "event 2"
