# encoding: utf-8

module Shellout
  class Table

    def initialize(table={})
      @data = []
      @data << table[:headers] if table.has_key? :headers
      @data += table[:rows]    if table.has_key? :rows
      @data << table[:footers] if table.has_key? :footers
      
      @has_headers = table.has_key? :headers
      @has_footers = table.has_key? :footers
    end

    def print(out=$stdout)
      return if @data.empty?
      
      separators = widths.map {|w| '─'*(w+2)}
  
      out.print '┌' << separators.join('┬') << "┐\n"
      @data.each_with_index do |r, i|
        if @has_footers and i == @data.size-1
          out.print '├' << separators.join('┼') << "┤\n"
        end
        if @has_headers and i == 0
          out.print '│ ' << r.zip(widths).map {|s,l| s.center(l)}.join(' │ ') << " │\n"
          out.print '├' << separators.join('┼') << "┤\n"
        else
          out.print '│ ' << r.to_a.join(' │ ') << " │\n"          
        end
      end
      out.print '└' << separators.join('┴') << "┘\n"
    end
    
    private
    
    def widths
      @widths ||= @data.transpose.map {|v| v.map(&:size).max }
    end
    
    def build_format(lengths)
      #
      #is_column_left_justified = Array.new(lengths.count, false)
      #
      #@data.row_vectors.each do |r|
      #  r.each do |c|
      #    if !r[c].strip.empty? && !r[c].match(/^\d+[:.,]?\d*$/)
      #      is_column_left_justified[c] = true
      #    end
      #  end
      #end
      #
      #lengths.reduce('│') do |f, l|
      #    justify = is_column_left_justified.shift ? '-' : ''
      #    f + " %#{justify}#{l}s │"
      #  end + "\n"
      #end
      #
    end
  end
end
