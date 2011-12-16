#!/usr/bin/env ruby

require 'shellout'
require 'shellout/command_loop'
require 'shellout/date_query'
require 'shellout/menu_query'
require 'shellout/task'
require 'shellout/query'

class App

  include Shellout

  def initialize
    @session = []
  end

  def define_course_task(dishes)
    Task.new do |t|
      t.dish     = MenuQuery.new(dishes)
      t.quantity = Query.new('How many?', 1)
      t.printf("%{quantity} %{dish} added to your order\n")
      t.on_call_done do
        @session << t
      end
    end
  end
  
  def main
  
    starters_task    = define_course_task(%w(Gazpacho Bruschetta))
    main_course_task = define_course_task(%w(Pizza Pasta))
    desserts_task    = define_course_task(%w(Gelato Tiramisu))
  
    checkout_task = Task.new do |t|
      t.date = DateQuery.new
      t.name = Query.new("Your name")
      t.on_call_done do
        confirmed = Query.new("Confirm (y|n)").call
        @session = [] if confirmed == 'y'
      end
    end
    
    view_order_task = ->do
      #FIXME ugly
      rows = @session.map do |t|
        [t.instance_variable_get(:@results)[:quantity], t.instance_variable_get(:@results)[:dish]]
      end
      Table(headers: %w(quantity dish), rows: rows).print
    end
    
    main_menu_items = {
      "Starters"      => starters_task,
      "Main courses"  => main_course_task,
      "Desserts"      => desserts_task,
      "View Order"    => view_order_task,
      "Checkout"      => checkout_task,
      "Exit"          => ->{ exit }
    }
    main_menu = MenuQuery.new(main_menu_items, true)
    
    puts "Give up to your hunger!"
    CommandLoop.new(main_menu).call
  end
end

App.new.main
