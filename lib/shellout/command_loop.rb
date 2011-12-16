
module Shellout
  class CommandLoop
    
    def initialize(menu)
      @menu = menu
    end
    
    def call
      loop do
        begin
          task = @menu.call
          task.call
        rescue Interrupt    # ^C
          puts              # Add a new line in case we are prompting
        end
      end
    end
    
  end
end
