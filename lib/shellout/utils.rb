require 'readline'

module Shellout
  module Utils
    
    def text_effect(code, text); "\e[#{code}m#{text}\e[0m"; end

    def bold(text); text_effect(1, text); end

    def ask(question='')
      answer = Readline.readline(bold("#{question}> "), true)
      answer.strip
    end
    
  end
end
