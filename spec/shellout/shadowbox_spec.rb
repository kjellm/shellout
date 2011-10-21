# encoding: utf-8

require 'stringio'
require 'shellout/shadowbox'

describe Shellout::Shadowbox do

  before(:each) do
    @out = StringIO.new
  end
  
  describe 'when title is empty' do
    it 'should print an empty box' do
      @box = Shellout::Shadowbox.new('')
      x = <<EOB
┌──────────────────────────────────────────┐ 
│                                          │▒
└──────────────────────────────────────────┘▒
  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
EOB
      @box.print(@out)
      @out.string.should == x
    end
  end
  
  describe 'when a short title is given' do
    it 'should print a padded box with centered title' do
      @box = Shellout::Shadowbox.new('short')
      x = <<EOB
┌──────────────────────────────────────────┐ 
│                  short                   │▒
└──────────────────────────────────────────┘▒
  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
EOB
      @box.print(@out)
      @out.string.should == x
    end
  end
  
  describe 'when a long title is given' do
    it 'should print a box that is big enough' do
      @box = Shellout::Shadowbox.new('a very extremely humongously large meaningless title')
      x = <<EOB
┌──────────────────────────────────────────────────────┐ 
│ a very extremely humongously large meaningless title │▒
└──────────────────────────────────────────────────────┘▒
  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
EOB
      @box.print(@out)
      @out.string.should == x
    end
  end
end
