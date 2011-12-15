Feature: View ordered dishes
  As a user
  I want to be able to see what I have ordered
  So that I can verify that the system has gotten it right
  
  Scenario: view ordered dishes
    Given that hunger is running
      And I order 1 Pizza
      And I order 2 Gelato
      And I choose to view ordered dishes
      And I quit
     Then I should see "┌──────────┬────────┐\n│ quantity │  dish  │\n├──────────┼────────┤\n│        1 │ Pizza  │\n│        2 │ Gelato │\n└──────────┴────────┘"
     #FIXME Could not get multiline pystrings to work (lexing error)

