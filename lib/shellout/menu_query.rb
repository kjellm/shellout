require 'shellout/utils'
require 'shellout'

module Shellout
  class MenuQuery

    include Utils
    include Shellout

    def initialize(items)
      # FIXME
      if items.is_a? Array
        new_items = {}
        items.each do |i|
          new_items[i] = i
        end
        items = new_items
      end
      @items = items
      @menu  = Menu(items.keys)
    end

    def execute
      @menu.print
      answer = ask
      @items.values[answer.to_i-1]
    end

    alias call execute

    private

    def only_one_option?
      @items.length == 1
    end

  end
end