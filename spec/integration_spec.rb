require 'spec_helper'

spec_helpers = Module.new do
  def matcher_for(str_or_regex)
    case str_or_regex
    when Regexp then match str_or_regex
    else             eq    str_or_regex
    end
  end

  def runs!(*program, out://, err:"", status:0)
    actual_out, actual_err, actual_status = Open3.capture3(*program)

    expect(actual_err).to matcher_for(err)
    expect(actual_out).to matcher_for(out)
    expect(actual_status.exitstatus).to eq status
  end
end

RSpec.describe 'rin' do
  include spec_helpers

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

  it 'sets the base before printing' do
    runs! 'rin', '15.inspect', out: %'"F"\n'
  end

  it 'prints help on -h and --help' do
    runs! 'rin', '-h',     out: /usage/i
    runs! 'rin', '--help', out: /usage/i
  end

  describe 'errors' do
    it 'notifies you if you omit the program' do
      runs! 'rin', '-8', '-P', status: 1,
                               err:    /no code specified/i,
                               out:    ''
    end

    it 'notifies you if you choose an invalid base' do
      runs! 'rin', '-36', '1', status: 0
      runs! 'rin', '-37', '1', status: 1,
                               err:    /invalid base/i,
                               out:    ''
    end

    it 'notifies you if you supply a nonexistent arg'
      # rin - '1'
  end
end


RSpec.describe 'ruby -rin -e' do
  include spec_helpers

  it 'defaults the base to hex' do
    runs! 'ruby', '-rin', '-e', 'p 7 + 7', out: "E\n"
  end

  it 'translates things that are probably numbers into the correct base'
end
