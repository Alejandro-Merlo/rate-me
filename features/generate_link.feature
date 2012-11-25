Feature: As a speaker I want to generate an event link to share and receive feedback

	Scenario: Successful creation of a link to one event
          Given the user "Jose" exists
	  And the "talk 1" of "Jose" exists for "2012-11-20"
	  And I am in the user "Jose" event list page
	  Then I should see "Share Link"
