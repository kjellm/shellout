require 'date'

module Shellout
  class Calendar
    
    def initialize(date=Date.today)
      @date = date
      @list_of_days = "Mo Tu We Th Fr Sa Su"
    end
    
    def print(out=$stdout)
      print_helper(out, Array(@date))
    end
    
    def print3(out=$stdout)
      print_helper(out, [@date.prev_month, @date, @date.next_month])
    end
    
    private
    
    def print_helper(out, dates)
      foo = dates.map do |for_date|
        bar = days(for_date)
        if is_current_month?(for_date)
          bar.map! {|d| d == Date.today.day  ? ansi_reverse_color(d) : d}
        end
        bar
      end
      first_year = dates.first.year
      same_year = dates.reduce(true) {|res, d| res && d.year == first_year}
      if same_year and dates.length > 1
        out.puts first_year.to_s.center((@list_of_days.length + 2) * (dates.length)  -  2)
      end
      dates.each do |for_date|
        head = Date::MONTHNAMES[for_date.month]
        head += " #{for_date.year}" if dates.length == 1 or !same_year
        out.print head.center(@list_of_days.length)
        out.print "  "
      end
      out.puts
      dates.each do |for_date|
        out.print @list_of_days
        out.print "  "
      end
      out.puts
      i = 0
      while true
        exhausted = 0
        foo.each do |bar|
          if i >= bar.length
            exhausted += 1
          else
            week = bar[i..i+6]
            week += Array.new(7 - week.length, "")
            out.print week.map {|s| "%2s" % s}.join " "
            out.print "  "
          end
        end
        break if exhausted == foo.length
        i += 7
        out.puts
      end
    end

    private
    
    def is_current_month?(date)
      Date.today.month == date.month
    end
    
    def days(for_date)
      first_day_of_month = Date.new(for_date.year, for_date.month)
      days = (1..last_day_of_month(first_day_of_month).day).to_a
      wday = (first_day_of_month.wday - 1) % 7
      days.unshift(*Array.new(wday, ""))
      days
    end
    
    def last_day_of_month(first_day_of_month)
      first_day_of_month.next_month-1
    end
    
    def ansi_reverse_color(s); "\e[7m#{s}\e[0m"; end
    
    
  end
end