module Shellout
  class Calendar
    
    def initialize(*dates)
      @dates = dates
      @list_of_days = "Mo Tu We Th Fr Sa Su"
      reset
    end
    
    def print(out=$stdout)
      @out=out
      @dates.each do |d|
        print_calendar(d)
        unless d == @dates.last # FIXME
          @col += 24
          @out.print ansi_cursor_up(@lines) + ansi_cursor_right(@col)
          @lines = 1
        end
      end
      reset
      #puts
    end

    private
      
    def reset
      @lines = 1
      @col   = 0
    end
    
    def print_calendar(for_date)
      print_heading(for_date)
      print_dates(for_date)
    end

    def print_heading(for_date)
      print_line("#{Date::MONTHNAMES[for_date.month]} #{for_date.year}".center(@list_of_days.length))
      print_line(@list_of_days)
    end
    
    def print_dates(for_date)
      week = []
      days(for_date).each_with_index do |d, i|
        d = is_current_month?(for_date) && d == Date.today.day \
          ? ansi_reverse_color(d) : d
        week << "%2s" % d 
        if end_of_week?(i)
          print_week(week)
          week = []
        end
      end
      print_week(week) unless week.empty?
      @out.puts
    end

    def print_week(week)
      print_line week.join(' ')
    end
    
    def end_of_week?(i)
      (i+1) % 7 == 0
    end
    
    def is_current_month?(date)
      Date.today.month == date.month
    end
  
    def print_line(s="")
      @lines += 1
      @out.print s
      @out.print @col == 0 ? "\n" : ansi_cursor_down(1) + ansi_cursor_left(@list_of_days.length)
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
    
    def ansi_cursor_up(n);    "\e[#{n}A"; end
    def ansi_cursor_down(n);  "\e[#{n}B"; end
    def ansi_cursor_left(n);  "\e[#{n}D"; end
    def ansi_cursor_right(n); "\e[#{n}C"; end
    
  end
end