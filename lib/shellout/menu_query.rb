require 'shellout/query'
require 'shellout'

module Shellout
  class MenuQuery

    include Shellout

    def initialize(items, last_is_the_zero_item=false)
      @items = items.is_a?(Array) ? Hash[*(items.zip(items).flatten)] : items
      @has_a_zero_item = last_is_the_zero_item
      initialize_menu
      @prompt_class = Query
    end

    def call
      loop do
        @menu.print
        answer = ask
        return answer if answer
        puts "Invalid user input!"
      end
    end

    def prompt_class=(klass)
      @prompt_class = klass
    end

    def ask
      return @items.values[0] if only_one_option?
      answer = @prompt_class.new('', 1).call.to_i
      return nil if answer < 0
      return nil if answer == 0 and !@has_a_zero_item
      index = (@has_a_zero_item and answer == "0") ? -1 : answer.to_i-1
      @items.values[index]
    end

    private
    
    def initialize_menu
      menu_items = @items.keys
      zero_item  = @has_a_zero_item ? menu_items.pop : nil
      @menu = Menu(menu_items, zero_item)
    end

    def only_one_option?
      @items.length == 1 && !@has_a_zero_item
    end

  end
end