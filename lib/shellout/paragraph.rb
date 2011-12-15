module Shellout
  class Paragraph
   
    def initialize(str)
      @str = str
      @padding = 0
      @width   = 80
    end
    
    def width(width)
      @width = width
      self
    end
    
    def padding(width)
      @padding = width
      self
    end

    def print(out=$stdout)
      text_width = @width - @padding
      text = ' '*@padding + @str
      # Stolen from ActionView::Helpers::TextHelper#word_wrap
      p = text.split("\n").collect do |line|
        line.length > text_width ? line.gsub(/(.{1,#{text_width}})(\s+|$)/, "\\1\n" + ' '*@padding).rstrip : line
      end * "\n"
      out.puts p
    end
             
  end
end