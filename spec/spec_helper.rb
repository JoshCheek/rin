require 'open3'

lib_path       = File.expand_path '../../lib', __FILE__
bin_path       = File.expand_path '../../bin', __FILE__
ENV['PATH']    = "#{bin_path}:#{ENV['PATH']}"
ENV['RUBYOPT'] = "-I #{lib_path} #{ENV['RUBYOPT']}"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.fail_fast = true
end
