require 'spec_helper'
require 'rin'

RSpec.describe 'rin' do
  specify 'rin always returns the same object' do
    # call it under various different `self`s
    expect(rin).to equal Object.new.instance_eval { rin }
  end

  def self.test_base(basename, base, tests)
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

  test_base 'hex', 16, 15 => ['15', 'F']
  test_base 'oct',  8, 15 => ['15', '17']
  test_base 'bin',  2, 10 => ['10', '1010']
  test_base 'dec', 10, 15 => ['15', '15']

  it 'exposes the current base' do
    expect(rin.base).to eq 10
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

  it 'returns the block value on .<base>' do
    expect(rin.hex { 'zomg' }).to eq 'zomg'
  end

  it 'allows for arbitrary base overrides'
  it 'works for bignums'
  it 'supports nested overrides'
  it 'can be enabled and disabled'
end
