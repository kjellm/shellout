# encoding: utf-8

module Shellout
  class Shadowbox
    
    MIN_WIDTH = 40
    
    def initialize(title)
      @title = title
    end
    
    def print(out=$stdout)
      length = [@title.length, MIN_WIDTH].max + 2 
      out.print "" <<
      '┌'  << '─' * length             <<  "┐ \n" <<
      '│ ' << @title.center(MIN_WIDTH) << " │▒\n" <<
      '└'  << '─' * length             <<  "┘▒\n" <<
      '  ' << '▒' * length             <<   "▒\n"
    end
    
  end
end