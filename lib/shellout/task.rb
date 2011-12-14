module Shellout
  class Task

    # For executing sub tasks in correct order, we depend on the fact that
    # hash iteration is in insert order

    def initialize
      @sub_tasks    = {}
      @on_call_done = ->{}
      yield self if block_given?
    end
  
    # A cute way to add sub tasks
    def method_missing(name, *args)
      super unless name =~ /=$/
      add_sub_task(name.to_s.chop, args.first)
    end
    
    def add_sub_task(name, sub)
      @sub_tasks[name.to_sym] = sub
    end

    def printf(format)
      @sub_tasks['printf'] = -> do
        super(format, @results)
      end
    end
  
    def on_call_done(&callback)
      @on_call_done = callback
    end
  
    def call
      @results = {}
      @sub_tasks.each do |k, sub|
        @results[k] = sub.call
      end
      @on_call_done.call
    end

  end  
end
