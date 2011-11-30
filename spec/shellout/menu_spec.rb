require 'stringio'
require 'shellout'

describe Shellout::Menu do

  include Shellout

  before(:each) do
    @out = StringIO.new
  end

  it "should work for a basic example" do
    Menu(%w(a b c)).print(@out)
    @out.string.should == <<EOT
 1. a
 2. b
 3. c
EOT
  end

  it "should print nothing when no items are given" do
    Menu([]).print(@out)
    @out.string.should == ''
  end

  it "should right justify the menu item number" do
    Menu(('a'..'j').to_a).print(@out)
    @out.string.should == <<EOT
  1. a
  2. b
  3. c
  4. d
  5. e
  6. f
  7. g
  8. h
  9. i
 10. j
EOT
  end
    

end