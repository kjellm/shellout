require 'date'

module Shellout
  class Date < ::Date
    
    def self.from_str(date_str, base=Date.today)
      raise ArgumentError.new("Can't convert nil to a Date") \
        if date_str.nil?
      
      args = [date_str, base]
      return parse_str_from_english(*args) \
          || parse_str_from_offset(*args)  \
          || parse_str_from_ymd(*args)     \
          || (raise ArgumentError.new(
                "Failed to convert String(#{date_str}) to a Date"))
    end

    private

    def self.parse_str_from_english(date_str, base)
      return base if date_str == 'today' || date_str.empty?
      return nil
    end
      
    def self.parse_str_from_offset(date_str, base)
      return case date_str.chars.first
      when '-'
        base - Integer(date_str[1..-1])
      when '+'
        base + Integer(date_str[1..-1])
      else
        nil
      end
    end
      
    def self.parse_str_from_ymd(date_str, base)
      date = date_str.split('-').collect {|d| d.to_i}
      case date.length
      when 1
        return Date.civil(base.year, base.month, *date)
      when 2
        return Date.civil(base.year, *date)
      when 3
        if date[0] < 70
          date[0] += 2000 
        elsif date[0] < 100
          date[0] += 1900
        end 
        return Date.civil(*date)
      end
      return nil
    end
    
  end
end
