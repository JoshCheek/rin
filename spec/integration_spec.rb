require 'spec_helper'

# error cases:
#   no program
#   invalid base
# -h / --help

RSpec.describe 'rin' do
  it 'prints the inspection of whatever the script evaluates to' do
    runs! 'rin', '"hello"', out: %'"hello"\n'
  end

  it 'sets __FILE__ to "-e", like Ruby\'s -e' do
    runs! 'rin', '__FILE__', out: %'"-e"\n'
  end

  it 'accepts preferred base as flags' do
    runs! 'rin', '-8', '7 + 7', out: "16\n"
  end

  it 'defaults the base to hex' do
    runs! 'rin', '7 + 7', out: "E\n"
  end

  it 'translates things that are probably numbers into the correct base'

  specify '-P turns off autoprinting' do
    runs! 'rin', '-P', '1+1', out: ''
  end
end


RSpec.describe 'ruby -rin -e' do
  it 'defaults the base to hex' do
    runs! 'ruby', '-rin', '-e', '"7 + 7"', out: "E\n"
  end

  it 'translates things that are probably numbers into the correct base'
end
