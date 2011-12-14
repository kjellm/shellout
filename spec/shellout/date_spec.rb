require 'shellout/date'

module Shellout
  describe Date do
    
    describe "#from_str" do
      
      before(:each) do
        @today = Date.today
      end

      
      context "when English date string is given" do
        it "should parse 'today'" do
          Date.from_str("today").should == @today
        end

        it "should parse '' as 'today'" do
          Date.from_str("").should == @today
        end
      end
   
   
      context "when an offset is given" do
        it "should parse '+1' as tomorrow" do
          Date.from_str("+1").should == @today+1
        end
        
        it "should parse '-1' as yesterday" do
          Date.from_str("-1").should == @today-1
        end
      end


      context "when only the day of month is given" do
        it "should parse '1'" do
          Date.from_str("1").should == Date.civil(@today.year, @today.month, 1)
        end
        
        it "should parse '20'" do
          Date.from_str("20").should == Date.civil(@today.year, @today.month, 20)
        end
      end


      context "when the month and day of month are given" do
        it "should parse '11-1'" do
          Date.from_str("11-1").should == Date.civil(@today.year, 11, 1)
        end
        
        it "should parse '11-01'" do
          Date.from_str("11-01").should == Date.civil(@today.year, 11, 1)
        end
      end

      context "when year, month, and day of month are given" do

        # Two digits in year
        it "should parse '11-11-11' as 2011-11-11" do
          Date.from_str("11-11-11").should == Date.civil(2011, 11, 11)
        end
        
        it "should parse '91-11-11' as 1991-11-11" do
          Date.from_str("91-11-11").should == Date.civil(1991, 11, 11)
        end
        
        # > Two digits in year
        it "should parse '111-11-1' as 111-11-1" do
          Date.from_str("111-11-1").should == Date.civil(111, 11, 1)
        end
        
        it "should parse '2008-08-26' as 2008-08-26" do
          Date.from_str("2008-08-26").should == Date.civil(2008, 8, 26)
        end
      end
      
      it "should fail on nil" do
        expect { Date.from_str(nil) }.to raise_error(ArgumentError)
      end
      
      it "should fail on strings containing junk" do
        expect { Date.from_str("foobar") }.to raise_error(ArgumentError)
      end

    end
  end
end
