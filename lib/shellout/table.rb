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
      format = build_format
      
      out.print '┌' << separators.join('┬') << "┐\n"
      @data.each_with_index do |r, i|
        if @has_headers and i == 0
          out.print '│ ' << center(r).join(' │ ') << " │\n"
          out.print '├' << separators.join('┼') << "┤\n"
        elsif @has_footers and i == @data.size-1
          out.print '├' << separators.join('┼') << "┤\n"
          out.printf(format, *r)          
        else
          out.printf(format, *r)          
        end
      end
      out.print '└' << separators.join('┴') << "┘\n"
    end
    
    private

    def center(row)
      row.zip(widths).map {|s,l| s.center(l)}      
    end
    
    def widths
      @widths ||= @data.transpose.map {|c| c.map(&:size).max }
    end
    
    def build_format
      data = @data.clone
      data.shift if @has_headers
      
      numeric_columns = data.transpose.map do |col|
        col.reduce(true) do |is_numeric, c|
          is_numeric &&= c.match(/\d+[:.,]?\d*$/)
        end
      end
      
      format = widths.reduce('│') do |f, l|
        justify = numeric_columns.shift ? '' : '-'
        f + " %#{justify}#{l}s │"
      end + "\n"
    end
  end
end
