# encoding: utf-8

require 'shellout'

describe Shellout do
  
  it 'should auto load shellout/shadowbox' do
    (Shellout.const_defined? :Shadowbox).should be_true
  end

  it 'should auto load shellout/table' do
    (Shellout.const_defined? :Table).should be_true
  end

end
