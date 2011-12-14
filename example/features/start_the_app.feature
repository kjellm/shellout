Feature: Start the app
  As a user of the system
  I want to be able to start the system
  In order to be able to use the system
  
  Scenario: Start the app
    Given that hunger is not running
    When I start hunger
     And I quit
    Then I shall see a greeting
     And I shall see the main menu
