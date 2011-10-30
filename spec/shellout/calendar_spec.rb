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
  
  describe 'when one date given' do
    it 'should print a calendar for the given month' do
      Shellout::Calendar.new(Date.new(2011, 10)).print(@out)
      @out.string.should == <<EOC
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
  end

  describe 'when three dates are given' do
    it 'should print all three calendars on one row' do
      Shellout::Calendar.new(Date.new(2011, 7), Date.new(2011, 8), Date.new(2011, 9)).print(@out)
      exp = <<EOC
     July 2011      
Mo Tu We Th Fr Sa Su
             1  2  3
 4  5  6  7  8  9 10
11 12 13 14 15 16 17
18 19 20 21 22 23 24
25 26 27 28 29 30 31

\e[8A\e[24C    August 2011     \e[1B\e[20DMo Tu We Th Fr Sa Su\e[1B\e[20D 1  2  3  4  5  6  7\e[1B\e[20D 8  9 10 11 12 13 14\e[1B\e[20D15 16 17 18 19 20 21\e[1B\e[20D22 23 24 25 26 27 28\e[1B\e[20D29 30 31\e[1B\e[20D
\e[8A\e[48C   September 2011   \e[1B\e[20DMo Tu We Th Fr Sa Su\e[1B\e[20D          1  2  3  4\e[1B\e[20D 5  6  7  8  9 10 11\e[1B\e[20D12 13 14 15 16 17 18\e[1B\e[20D19 20 21 22 23 24 25\e[1B\e[20D26 27 28 29 30\e[1B\e[20D
EOC
      #      July 2011              August 2011            September 2011   
      # Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su    Mo Tu We Th Fr Sa Su
      #              1  2  3     1  2  3  4  5  6  7              1  2  3  4
      #  4  5  6  7  8  9 10     8  9 10 11 12 13 14     5  6  7  8  9 10 11
      # 11 12 13 14 15 16 17    15 16 17 18 19 20 21    12 13 14 15 16 17 18
      # 18 19 20 21 22 23 24    22 23 24 25 26 27 28    19 20 21 22 23 24 25
      # 25 26 27 28 29 30 31    29 30 31                26 27 28 29 30
      #
      @out.string.inspect.should == exp.inspect # using inspect to help debugging
    end
  end
end