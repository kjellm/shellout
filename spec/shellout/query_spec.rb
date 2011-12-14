require 'shellout/query'

module Shellout
  describe Query do

    it "should show a nice prompt containing the given question" do
      query = Query.new("what?")
      io = double('io')
      io.should_receive(:readline).with("\e[1mwhat?> \e[0m", true).and_return('')
      query.io = io
      query.call
    end

    it "should show a nice prompt containing the given question and default" do
      query = Query.new("what?", "what what?")
      io = double('io')
      io.should_receive(:readline).with("\e[1mwhat? [what what?]> \e[0m", true).and_return('')
      query.io = io
      query.call
    end

    it "should return the default when an empty answer is given" do
      query = Query.new("The Ultimate Answer to the Ultimate Question of Life, The Universe, and Everything", "42")
      io = double('io')
      io.should_receive(:readline).and_return("\n")
      query.io = io
      query.call.should == "42"
    end
    
    it "should return the answer given" do
      query = Query.new("The Ultimate Answer to the Ultimate Question of Life, The Universe, and Everything")
      io = double('io')
      io.should_receive(:readline).and_return("42\n")
      query.io = io
      query.call.should == "42"
    end
    
  end
end