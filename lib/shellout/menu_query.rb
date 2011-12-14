require 'shellout/query'
require 'shellout'

module Shellout
  class MenuQuery

    include Shellout

    def initialize(items, last_is_the_zero_item=false)
      @items = items.is_a?(Array) ? Hash[*(items.zip(items).flatten)] : items
      menu_items = @items.keys
      zero_item  = nil
      if last_is_the_zero_item
        zero_item = menu_items.pop
      end
      @menu = Menu(menu_items, zero_item)
      @has_a_zero_item = last_is_the_zero_item
    end

    def call
      loop do
        @menu.print
        if only_one_option?
          return @items.values[0]
        end
        answer = Query.new.call
        index = @has_a_zero_item and answer == "0" ? -1 : answer.to_i-1
        value = @items.values[index]
        return value if value
        puts "Invalid user input!"
      end
    end

    private

    def only_one_option?
      @items.length == 1 && !@has_a_zero_item
    end

  end
end