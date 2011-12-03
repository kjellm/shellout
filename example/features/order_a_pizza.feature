Feature: Order a Pizza
  As a pathetic person who is unable to make my own supper
  I want to order a pizza for tomorrows supper
  In order to not starve to death
  
  Scenario: Order a Pizza
    Given that hunger is running
    When I choose main course from the main menu
     And I choose Pizza from the main course menu
     And I choose the default quantity
     And I quit 
    Then I shall see "1 Pizza added to your order"