require 'readline'

module Shellout
  class Query

    def initialize(question='', default=nil)
      @question = question + (default.nil? ? '' : " [#{default}]")
      @default  = default
      @io       = Readline
    end

    def io=(io)
      @io = io
    end

    def call
      answer = ask(@question)
      return answer == '' ? @default : answer
    end
    
    private
    
    def bold(text); "\e[1m#{text}\e[0m"; end

    def ask(question='')
      answer = @io.readline(bold("#{question}> "), true)
      answer.strip
    end
    
  end
end
