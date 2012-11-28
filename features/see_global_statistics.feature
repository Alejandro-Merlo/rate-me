Feature: As a speaker I want to see global statistics

	Scenario: Successful access to statistics
          Given the user "Rin" exists
	  And the "Hellish talk 1" of "Rin" exists for "2012/12/30"
          And the "Hellish talk 2" of "Rin" exists for "2012/12/31"
	  And I am in the user "Rin" global stats page
	  Then I should see "Global statistics"
