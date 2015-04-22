require 'spec_helper'
require 'rin'

# base!

RSpec.describe 'rin' do
  specify 'always returns the same object' do
    # call it under various different `self`s
    expect(rin).to equal Object.new.instance_eval { rin }
  end

  describe '.base(n) { ... }' do
    specify '.base(n) { ... } allows for arbitrary base overrides' do
      twenty_four_base_thirteen =
        rin.base(13) { (12 + 12).inspect }
      expect(twenty_four_base_thirteen).to eq '1B'
    end

    it 'resets the base on .<base> { ... }, even if the block raises an exception' do
      expect {
        rin.hex do
          expect(rin.base).to eq 16
          raise 'zomg'
        end
      }.to raise_error RuntimeError, 'zomg'
      expect(rin.base).to eq 10
    end

    it 'raises the ArgumentError that to_s would, if given an invalid base' do
      expect { 15.to_s 37 }.to raise_error ArgumentError, /invalid/i
      expect { rin.base(37) { nil } }.to raise_error ArgumentError, /invalid/i
      expect(rin.base).to eq 10
    end
  end

  describe 'named bases' do
    def self.test_named_base(basename, base, tests)
      specify ".#{basename} { ... } sets the inspect to base #{base} within the block" do
        tests.each do |int, (dec_inspect, base_inspect)|
          expect(int.inspect).to eq dec_inspect
          rin.__send__ basename do
            expect(int.inspect).to eq base_inspect
          end
          expect(int.inspect).to eq dec_inspect
        end
      end

      specify ".#{basename}! sets the inspect to #{base} permanently" do
        tests.each do |int, (dec_inspect, base_inspect)|
          expect(int.inspect).to eq dec_inspect
          rin.__send__ "#{basename}!"
          expect(int.inspect).to eq base_inspect
          rin.dec!
        end
      end
    end

    test_named_base 'hex', 16, 15 => ['15', 'F']
    test_named_base 'oct',  8, 15 => ['15', '17']
    test_named_base 'bin',  2, 10 => ['10', '1010']
    test_named_base 'dec', 10, 15 => ['15', '15']
  end

  it 'exposes the current base' do
    expect(rin.base).to eq 10
  end

  it 'returns the block value on .<base>' do
    expect(rin.hex { 'zomg' }).to eq 'zomg'
  end

  it 'works for bignums' do
    n = 10**1000
    expect(n).to be_a_kind_of Bignum
    expect(rin.hex { n.inspect })
      .to eq n.to_s(16).upcase
  end

  it 'supports nested overrides' do
    expect(15.inspect).to eq '15'
    rin.hex do
      expect(15.inspect).to eq 'F'
      rin.oct { expect(15.inspect).to eq '17' }
      expect(15.inspect).to eq 'F'
    end
    expect(15.inspect).to eq '15'
  end

  it 'can be enabled and disabled' do
    rin.hex!
    expect(15.inspect).to eq 'F'
    rin.disable!
    expect(15.inspect).to eq '15'
    rin.enable!
    expect(15.inspect).to eq 'F'
    rin.dec!
  end
end
