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
      print_headings(out, dates)
      print_days(out, dates)
    end

    def print_headings(out, dates)
      print_heading_year(out, dates)
      print_heading_months(out, dates)
      print_heading_name_of_days(out, dates)
    end

    def print_year_on_a_separate_line?(dates)
      first_year = dates.first.year
      same_year = dates.reduce(true) {|res, d| res && d.year == first_year}
      same_year and dates.length > 1
    end

    def print_heading_year(out, dates)
      if print_year_on_a_separate_line?(dates)
        out.puts dates.first.year.to_s.center((@list_of_days.length + 2) * (dates.length)  -  2)
      end
    end

    def print_heading_months(out, dates)
      dates.each do |for_date|
        head = Date::MONTHNAMES[for_date.month]
        head += " #{for_date.year}" unless print_year_on_a_separate_line?(dates)
        out.print head.center(@list_of_days.length)
        out.print "  "
      end
      out.puts
    end

    def print_heading_name_of_days(out, dates)
      dates.each do |for_date|
        out.print @list_of_days
        out.print "  "
      end
      out.puts
    end      

    def print_days(out, dates)
      # FIXME: UGLY!!!
      foo = dates.map do |for_date|
        bar = days(for_date)
        if is_current_month?(for_date) && is_current_year?(for_date)
          bar.map! {|d| d == Date.today.day  ? ansi_reverse_color(d) : d}
        end
        bar
      end
      i = 0
      while true
        num_done = 0
        foo.each do |bar|
          if i >= bar.length
            num_done += 1
          else
            week = bar[i..i+6]
            week = push_empty_strings_for_missing_week_days(week)
            out.print week.map {|s| "%2s" % s}.join " "
            out.print "  "
          end
        end
        break if num_done == foo.length
        i += 7
        out.puts
      end
    end
    
    def is_current_month?(date)
      Date.today.month == date.month
    end
    
    def is_current_year?(date)
      Date.today.year == date.year
    end
    
    def days(for_date)
      days = (1..last_day_of_month(for_date).day).to_a
      unshift_empty_strings_for_missing_week(days, for_date)
    end
    
    def unshift_empty_strings_for_missing_week(days, date)
      wday = (first_day_of_month(date).wday - 1) % 7
      Array.new(wday, "") + days
    end

    def push_empty_strings_for_missing_week_days(week)
      week + Array.new(7 - week.length, "")
    end
    
    def first_day_of_month(date)
      Date.new(date.year, date.month)
    end
    
    def last_day_of_month(date)
      first_day_of_month(date).next_month-1
    end
    
    def ansi_reverse_color(s); "\e[7m#{s}\e[0m"; end
    
    
  end
end
