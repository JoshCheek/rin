require 'spec_helper'
require 'rin'

RSpec.describe 'rin' do
  # rin.hex { 15 }  # => "0xF"
  # rin.oct { 15 }  # => "017"
  # rin.bin { 15 }  # => "0b1111"
  # rin.dec { 15 }  # => "15"
  def self.test_base(basename, base, tests)
    specify "#{basename} { ... } sets the inspect to base #{base} within the block" do
      tests.each do |int, (dec_inspect, base_inspect)|
        expect(int.inspect).to eq dec_inspect
        rin.__send__ basename do
          expect(int.inspect).to eq base_inspect
        end
        expect(int.inspect).to eq dec_inspect
      end
    end

    specify "#{basename}! sets the inspect to #{base} permanently" do
      tests.each do |int, (dec_inspect, base_inspect)|
        expect(int.inspect).to eq dec_inspect
        rin.__send__ "#{basename}!"
        expect(int.inspect).to eq base_inspect
        rin.dec!
      end
    end
  end

  test_base 'hex', 16, 15 => ['15', 'F']
  test_base 'oct',  8, 15 => ['15', '17']
  test_base 'bin',  2, 10 => ['10', '1010']
  test_base 'dec', 10, 15 => ['15', '15']
  # when the block raises an exception
  # works for bignums
  # can have nested overrides
end
