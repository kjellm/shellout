# encoding: utf-8

require 'stringio'
require 'shellout'

describe Shellout::Table do

  include Shellout

  before(:each) do
    @out = StringIO.new
  end
  
  describe 'when no parameters' do
    it 'should not print anything' do
      Table().print(@out)
      @out.string.should == ''
    end
  end

  describe 'when table consists of only a single data row' do
    it 'should print a single row table' do
      Table(rows: [%w{a b c}]).print(@out)
      @out.string.should == <<'EOT'
┌───┬───┬───┐
│ a │ b │ c │
└───┴───┴───┘
EOT
    end
  end
  
  describe 'when only given headers' do 
    it 'should print headers and one empty row' do
      Table(headers: %w{a b c}).print(@out)
      @out.string.should == <<'EOT'
┌───┬───┬───┐
│ a │ b │ c │
├───┼───┼───┤
└───┴───┴───┘
EOT
    end
  end

  describe 'when all parameters are defined' do 
    it 'should print a nice table' do
      Table(headers: %w{a b c}, rows: [%w{d e f}, %w{g h i}], footers: %w{j k l}).print(@out)
      @out.string.should == <<'EOT'
┌───┬───┬───┐
│ a │ b │ c │
├───┼───┼───┤
│ d │ e │ f │
│ g │ h │ i │
├───┼───┼───┤
│ j │ k │ l │
└───┴───┴───┘
EOT
    end
  end
  
  it 'should center headers' do
    Table(headers: %w{a b c}, rows: [%w{123 456 789}]).print(@out)
    @out.string.each_line.to_a[1].should == "│  a  │  b  │  c  │\n"
  end
  
  it 'should_right_justify_numbers' do
    Table(headers: %w{aaaa bb ccc}, rows: [%w{123 4 56}]).print(@out)
    @out.string.should == <<'EOT'
┌──────┬────┬─────┐
│ aaaa │ bb │ ccc │
├──────┼────┼─────┤
│  123 │  4 │  56 │
└──────┴────┴─────┘
EOT
  end
  
  it 'should handle an example with some "real" data' do
    Table(
      headers: %w{project code hours price},
      rows:    [%w{nice_project_1 a 7:30 100.00}, %w{nice_project_2 b 7:30 87.50}],
      footers: %w{Sum - 15:00 187.50},
    ).print(@out)
    @out.string.should == <<'EOT'
┌────────────────┬──────┬───────┬────────┐
│    project     │ code │ hours │ price  │
├────────────────┼──────┼───────┼────────┤
│ nice_project_1 │ a    │  7:30 │ 100.00 │
│ nice_project_2 │ b    │  7:30 │  87.50 │
├────────────────┼──────┼───────┼────────┤
│ Sum            │ -    │ 15:00 │ 187.50 │
└────────────────┴──────┴───────┴────────┘
EOT
  end
end    
