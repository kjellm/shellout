require 'shellout/date_parser'
require 'date'

module Shellout
  describe DateParser do
    
    describe "#parse" do
      
      before(:each) do
        @today = Date.today
      end
      
      context "plain text" do
        it "should parse 'today'" do
          DateParser.parse("today").should == @today
        end

        it "should parse ''" do
          DateParser.parse("").should == @today
        end
      end
   
   
      context "offsets" do
        it "should parse '+1'" do
          DateParser.parse("+1").should == @today+1
        end
        
        it "should parse '-1'" do
          DateParser.parse("-1").should == @today-1
        end
      end

      context "only day of month" do
        it "should parse '1'" do
          DateParser.parse("1").should == Date.civil(@today.year, @today.month, 1)
        end
        
        it "should parse '20'" do
          DateParser.parse("20").should == Date.civil(@today.year, @today.month, 20)
        end
      end

      context "month and day of month" do
        it "should parse '11-1'" do
          DateParser.parse("11-1").should == Date.civil(@today.year, 11, 1)
        end
        
        it "should parse '11-01'" do
          DateParser.parse("11-01").should == Date.civil(@today.year, 11, 1)
        end
      end

      context "Y-M-D" do
        it "should parse '11-11-11'" do
          DateParser.parse("11-11-11").should == Date.civil(2011, 11, 11)
        end
        
        it "should parse '111-11-11'" do
          DateParser.parse("111-11-11").should == Date.civil(111, 11, 11)
        end
        
        it "should parse '91-11-11'" do
          DateParser.parse("91-11-11").should == Date.civil(2091, 11, 11)
        end
        
        it "should parse '2008-08-26'" do
          DateParser.parse("2008-08-26").should == Date.civil(2008, 8, 26)
        end
      end
      
      it "should fail on nil"
      
      it "should fail on strings containing junk"

    end
  end
end