require 'open3'

module SpecHelpers
  def matcher_for(str_or_regex)
    case str_or_regex
    when Regexp then match str_or_regex
    else             eq    str_or_regex
    end
  end

  def runs!(*program, out:"", err:"", status:0)
    actual_out, actual_err, actual_status = Open3.capture3(*program)

    expect(actual_err).to matcher_for(err)
    expect(actual_out).to matcher_for(out)
    expect(actual_status.exitstatus).to eq status
  end
end

lib_path       = File.expand_path '../lib', __dir__
bin_path       = File.expand_path '../bin', __dir__
ENV['PATH']    = "#{bin_path}:#{ENV['PATH']}"
ENV['RUBYOPT'] = "-I #{lib_path} #{ENV['RUBYOPT']}"

RSpec.configure do |config|
  config.include SpecHelpers
  config.disable_monkey_patching!
  config.fail_fast = true
end
