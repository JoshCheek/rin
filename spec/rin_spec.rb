require 'rin'

RSpec.describe 'rin' do
  # rin.hex { 15 }  # => "0xF"
  # rin.oct { 15 }  # => "017"
  # rin.bin { 15 }  # => "0b1111"
  # rin.dec { 15 }  # => "15"
  def self.test_base(basename, base)
    specify "#{basename} { ... } sets the inspect to base #{base} within the block"
    specify "#{basename}! sets the inspect to #{base} permanently"
  end

  test_base 'hex', 16
  test_base 'oct', 8
  test_base 'bin', 15
  test_base 'dec', 10
end
