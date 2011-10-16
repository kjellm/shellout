# encoding: utf-8

require 'stringio'
require 'shellout/table'

describe Shellout::Table do

  before(:each) do
    @out = StringIO.new
  end
  
  describe 'when no parameters' do
    it 'should not print anything' do
      Shellout::Table.new.print(@out)
      @out.string.should == ''
    end
  end

  describe 'table with only a single data row' do
    it 'should print a single row table' do
      Shellout::Table.new(rows: [%w{a b c}]).print(@out)
      @out.string.should == <<'EOT'
┌───┬───┬───┐
│ a │ b │ c │
└───┴───┴───┘
EOT
    end
  end
  
  describe 'when only given headers' do 
    it 'should print headers and one empty row' do
      Shellout::Table.new(headers: %w{a b c}).print(@out)
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
      Shellout::Table.new(headers: %w{a b c}, rows: [%w{d e f}, %w{g h i}], footers: %w{j k l}).print(@out)
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
    Shellout::Table.new(headers: %w{a b c}, rows: [%w{123 456 789}]).print(@out)
    @out.string.each_line.to_a[1].should == "│  a  │  b  │  c  │\n"
  end
  
end    
