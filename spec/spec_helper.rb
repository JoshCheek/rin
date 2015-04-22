require 'open3'

module SpecHelpers
  def runs!(*program, out:"", err:"", status:0)
    actual_out, actual_err, actual_status = Open3.capture3(*program)
    expect(actual_out   ).to eq out
    expect(actual_err   ).to eq err
    expect(actual_status).to eq out
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
  config.disable_monkey_patching!
  config.fail_fast = true
end
