module Shellout
  module DateParser
    
    def self.parse(date_str, base=Date.today)
      raise ArgumentError.new('Invalid date') if date_str.nil? # FIXME return some sort of nil date object?
      
      # Today (default)
      if date_str == 'today' || date_str.empty?
        return base
      end
      
      # Base offset
      case date_str.chars.first
      when '-'
        return base - Integer(date_str[1..-1])
      when '+'
        return base + Integer(date_str[1..-1])
      end
      
      # 
      date = date_str.split('-').collect {|d| d.to_i}
      case date.length
      when 1
        return Date.civil(base.year, base.month, *date)
      when 2
        return Date.civil(base.year, *date)
      when 3
        date[0] += 2000 if date[0] < 100
        return Date.civil(*date)
      end
      
      raise ArgumentError.new('Invalid date')
    end
    
  end
end