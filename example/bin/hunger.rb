#!/usr/bin/env ruby

require 'shellout'
require 'shellout/menu_query'

include Shellout

require 'readline'

# FIXME rename execute to call everywhere? think execute communicates the meaning more preciesly
Proc.send(:alias_method, :execute, :call)

def text_effect(code, text); "\e[#{code}m#{text}\e[0m"; end

def bold(text); text_effect(1, text); end

def ask(question='')
  answer = Readline.readline(bold("#{question}> "), true)
  answer.strip
end

class Task

  def initialize
    @sub_tasks = {}
    yield self
  end
  
  def method_missing(name, *args)
    super unless name =~ /=$/ # FIXME
    name = name.to_s.chop
    @sub_tasks[name] = args.first
  end
  
  def confirm
    obj = ->do
      p @results
      ask("Confirm (y|n)")
    end
    @sub_tasks['confirm'] = obj
  end
  
  def execute
    @results = {}
    @sub_tasks.each do |k, v|
      @results[k] = v.execute
      p @results
    end
  end
  
end


class DateQuery
   
   def execute
     answer = ask("Date ([today] | ?)")
     if answer == '?'
       print_help
       return execute
     end
     DateParser.parse(answer)
   end
   
   private

   def print_help
     puts "Accepted formats:"
     puts "        today | (+|-)n | [[[YY]YY]-[M]M]-[D]D"
     puts
     Calendar().print3
   end
   
end

# FIXME this is basically just a factory for constructing Date objects from a specially formated string.
class DateParser
  
  def self.parse(date_str, base=Date.today)
    raise ArgumentError.new('Invalid date') if date_str.nil? # FIXME return some sort of nil date object?
    
    # Today (default)
    if date_str == 'today' || date_str.empty?
      return Date.today
    end
    
    # Base offset
    case date_str.chars.first
    when '-'
      return base - Integer(date_str[1..-1])
    when '+'
      return base + Integer(date_str[1..-1])
    end
    
    # 
    date = date_str.split('-').collect {|d| d.to_i}
    case date.length
    when 1
      return Date.civil(base.year, base.month, *date)
    when 2
      return Date.civil(base.year, *date)
    when 3
      date[0] += 2000 if date[0] < 100
      return Date.civil(*date)
    end
    
    raise ArgumentError.new('Invalid date')
  end
  
end
 

class TextQuery

  def initialize(question='', default=nil)
    @question = question
    @default  = default.nil? ? '' : "[#{default}]"
  end

  def execute
    answer = ask("#@question#@default")
  end

end


class CommandLoop
  
  def initialize(menu)
    @menu = menu
  end
  
  def execute
    loop do
      begin
        task = @menu.execute
        task.execute
      rescue Interrupt    # ^C
        puts              # Add a new line in case we are prompting
      end
    end
  end
  
end

class App

  def define_course_task(dishes)
    Task.new do |t|
      t.dish     = Shellout::MenuQuery.new(dishes)
      t.quantity = TextQuery.new('How many?', 1)
    end
  end
  
  def main
  
    starters_task    = define_course_task(%w(Gazpacho Bruschetta))
    main_course_task = define_course_task(%w(Pizza Pasta))
    desserts_task    = define_course_task(%w(Gelato Tiramisu))
  
    checkout_task = Task.new do |t|
      t.date = DateQuery.new
      t.name = TextQuery.new("Your name")
      t.confirm
    end
    
    order_history_task = ->do
      Table(headers: %w(date name dishes_ordered)).print
    end
    
    main_menu = Shellout::MenuQuery.new({
      "Starters"      => starters_task,
      "Main courses"  => main_course_task,
      "Desserts"      => desserts_task,
      "Checkout"      => checkout_task,
      "Order History" => order_history_task,
      "Exit"          => ->{ exit }
    })
    
    puts "Give up to your hunger!"
    CommandLoop.new(main_menu).execute
  end
end

App.new.main