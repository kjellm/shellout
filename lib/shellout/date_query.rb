# -*- coding: utf-8 -*-
require 'shellout/query'
require 'shellout/date'

module Shellout
  class DateQuery < Query
 
    def initialize
      super("Date (?)", "today")
    end
   
    def call
      loop do
        date = super
        return date if date
      end
    end
    
    private
    
    def ask
      answer = super
      if answer == '?'
        print_help
        return
      end
      parse(answer)
    end
    
    def parse(answer)
      Shellout::Date.from_str(answer)
    rescue => e
      puts e.message
    end
    
    def print_help
      puts <<'EOT'
Accepted input formats:
            today - today
           [+|-]N - ±N days from today
              D?D - FIXME
          M?M-D?D - FIXME
  (YY)?YY-M?M-D?D - FIXME

EOT
       Shellout::Calendar.new.print3
    end

  end
end
