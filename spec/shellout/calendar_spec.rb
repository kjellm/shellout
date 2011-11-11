require 'date'
require 'stringio'
require 'shellout/calendar'

class Date
  def self.today
    Date.new(2011, 10, 30)
  end
end

describe Shellout::Calendar do

  before(:each) do
    @out = StringIO.new
  end
  
  describe 'print' do

    it 'should print a calendar for the given month' do
      Shellout::Calendar.new(Date.new(2011, 7)).print(@out)
      res = @out.string.gsub(/\s+\n/, "\n")
      res.should == <<EOC
     July 2011
Mo Tu We Th Fr Sa Su
             1  2  3
 4  5  6  7  8  9 10
11 12 13 14 15 16 17
18 19 20 21 22 23 24
25 26 27 28 29 30 31
EOC
      end
    end

    it 'should print a calendar for this month when no date given' do
      Shellout::Calendar.new().print(@out)
      res = @out.string.gsub(/\s+\n/, "\n")
      res.should == <<EOC
    October 2011
Mo Tu We Th Fr Sa Su
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 \e[7m30\e[0m
31
EOC
    end

  describe 'print3' do
    it 'should print the months before, at given, and after. Year on a separate line' do
      Shellout::Calendar.new(Date.new(2011, 8)).print3(@out)
      res = @out.string.gsub(/\s+\n/, "\n")
      res.should == <<EOC
                              2011
        July                 August              September
Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
             1  2  3   1  2  3  4  5  6  7            1  2  3  4
 4  5  6  7  8  9 10   8  9 10 11 12 13 14   5  6  7  8  9 10 11
11 12 13 14 15 16 17  15 16 17 18 19 20 21  12 13 14 15 16 17 18
18 19 20 21 22 23 24  22 23 24 25 26 27 28  19 20 21 22 23 24 25
25 26 27 28 29 30 31  29 30 31              26 27 28 29 30
EOC
    end

    it 'Should print year together with month names when not same year' do
      Shellout::Calendar.new(Date.new(2011, 12)).print3(@out)
      res = @out.string.gsub(/\s+\n/, "\n")
      res.should == <<EOC
   November 2011         December 2011          January 2012
Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
    1  2  3  4  5  6            1  2  3  4                     1
 7  8  9 10 11 12 13   5  6  7  8  9 10 11   2  3  4  5  6  7  8
14 15 16 17 18 19 20  12 13 14 15 16 17 18   9 10 11 12 13 14 15
21 22 23 24 25 26 27  19 20 21 22 23 24 25  16 17 18 19 20 21 22
28 29 30              26 27 28 29 30 31     23 24 25 26 27 28 29
30 31
EOC
    end
  end
end