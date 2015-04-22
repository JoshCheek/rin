require 'open3'

module SpecHelpers
  def runs!(*program, out:"", err:"", status:0)
    actual_out, actual_err, actual_status = Open3.capture3(*program)
    expect(actual_err).to eq err # err first, for better feedback
    expect(actual_out).to eq out
    expect(actual_status.exitstatus).to eq status
  end
end

bin_path    = File.expand_path '../bin', __dir__
ENV['PATH'] = "#{bin_path}:#{ENV['PATH']}"

RSpec.configure do |config|
  config.include SpecHelpers
  config.disable_monkey_patching!
  config.fail_fast = true
end
