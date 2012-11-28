Feature: As a speaker I want to find events to view statistics

	Scenario: Successful matching of the event
          Given the user "Laura" exists
	  And the "I like talk" of "Laura" exists for "2012/12/01"
	  And I am in the user "Laura" event list page
	  And I fill in "search_field" with "I like"
	  When I press "Search event"
	  Then I should see "I like talk"
