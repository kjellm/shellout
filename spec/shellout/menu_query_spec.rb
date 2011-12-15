require 'shellout/menu_query'

module Shellout
  describe MenuQuery do
    
    describe "#ask" do
      before :each do
        @query = MenuQuery.new(%w(a b c))
      end
      
      def make_prompt_return(value)
        prompt = double('prompt')
        prompt.stub_chain(:new, :call).and_return(value)
        @query.prompt_class = prompt    
      end

      it "should return first element when prompt query returns '1'" do
        make_prompt_return('1')
        @query.ask.should == 'a'
      end

      it "should return second element when prompt query returns '2'" do
        make_prompt_return('2')
        @query.ask.should == 'b'
      end

      it "should return nil if user answer is invalid (too large)" do
        make_prompt_return('9')
        @query.ask.should == nil
      end

      it "should return nil if user answer is invalid (0)" do
        make_prompt_return('0')
        @query.ask.should == nil
      end
    end
    
  end
end
