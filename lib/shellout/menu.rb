module Shellout
  class Menu
    
    def initialize(items, zero_item=nil)
      @items     = items
      @zero_item = zero_item
    end
    
    def padding; 1; end
    
    def print(out=$stdout)
      format = menu_item_format
      @items.each_with_index do |item, i|
        out.printf format, i+1, item
      end
      out.printf format, 0, @zero_item unless @zero_item.nil?
    end

    private

    def menu_item_format
      return if @items.empty?
      max_digits = Math.log10(@items.length).floor + padding
      " %#{max_digits}d. %s\n"
    end

  end
end    