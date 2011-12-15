Given /^that hunger is not running$/ do
end

When /^I start hunger$/ do
  steps %{When I run `hunger.rb` interactively}
end

When /^I quit$/ do
  steps %{When I type "6"}
end

Then /^I shall see a greeting$/ do
  steps %{Then the stdout should contain "Give up to your hunger!"}
end

Then /^I shall see the main menu$/ do
  steps %{Then the stdout should contain:
    """
     1. Starters
     2. Main courses
     3. Desserts
     4. View Order
     5. Checkout
     0. Exit
    """
    }
end

Given /^that hunger is running$/ do
  steps %{When I start hunger}
end

When /^I choose main course from the main menu$/ do
  steps %{When I type "2"}
end

When /^I choose Pizza from the main course menu$/ do
  steps %{When I type "1"}
end

When /^I choose the default quantity$/ do
  steps %{When I type ""}
end

Then /^I should see "([^"]*)"$/ do |arg1|
  steps %{Then the stdout should contain "#{arg1}"}
end

Given /^I order (\d+) Pizza$/ do |quantity|
  steps %{
    When I type "2"
    When I type "1"
    When I type "#{quantity}"
  }
end

Given /^I order (\d+) Gelato$/ do |quantity|
  steps %{
    When I type "3"
    When I type "1"
    When I type "#{quantity}"
  }
end

Given /^I choose to view ordered dishes$/ do
  steps %{When I type "4"}
end

Then /^I should see:$/ do |string|
  steps %{Then the stdout should contain "#{string}"}
end
