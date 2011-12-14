require 'shellout/task'
require 'stringio'

module Shellout
  describe Task do

    it "should execute it's sub tasks" do
      st1 = mock('subtask1')
      st2 = mock('subtask2')
      [st1, st2].each {|st| st.should_receive(:call)}

      task = Task.new do |t|
        t.step_one = st1
        t.step_two = st2
      end
      task.call
    end

    it "should call the on_call_done callback when all sub tasks are done executing" do
      callback = mock('callback')
      callback.should_receive(:call)
      t = Task.new
      t.on_call_done = callback
      t.call
    end
    
    it "should allow formatted printing of sub task results" do
      begin
        $stdout = StringIO.new
        task = Task.new do |t|
          t.foo = ->{"Hello"}
          t.bar = ->{"World!"}
          t.printf("%{foo} %{bar}\n")
        end
        task.call
        $stdout.string.should == "Hello World!\n"
      ensure
        $stdout = STDOUT
      end
    end

  end
end