require 'shellout/paragraph'

module Shellout
  describe Paragraph do

    before(:each) do
      @out = StringIO.new
    end
    
    it "should leave short lines alone" do
      Paragraph.new('A short paragraph').print(@out)
      @out.string.should == "A short paragraph\n"
    end
    
    it "should wrap a long line" do
      Paragraph.new('A really long paragraph containing nonsense, gibberish, and foobar').width(20).print(@out)
      @out.string.should == <<EOT
A really long
paragraph containing
nonsense, gibberish,
and foobar
EOT
    end

    it "should add padding in the left margin if specified" do
      Paragraph.new('A really long paragraph containing nonsense, gibberish, and foobar').width(20).padding(2).print(@out)
      @out.string.should == <<EOT
  A really long
  paragraph
  containing
  nonsense,
  gibberish, and
  foobar
EOT
    end
      
    
  end
end