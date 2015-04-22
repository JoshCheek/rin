require 'open3'


RSpec.describe 'rin' do
  it 'prints whatever the script evaluates to'
    # rin '"hello"' // hello
  it 'sets __FILE__ to "-e", like Ruby\'s -e'
    # rin '__FILE__' // -e
  it 'accepts preferred base as flags'
    # rin -8 '7 + 7' // 16
  it 'defaults the base to hex'
    # rin '7 + 7' // e
  it 'translates things that are probably numbers into the correct base'
  specify '-P turns off autoprinting'
    # rin -P '1+1' //
end


RSpec.describe 'ruby -rin -e' do
  it 'accepts preferred base as flags'
    # rin -8 '7 + 7' // 16
  it 'defaults the base to hex'
    # rin '7 + 7' // e
  it 'translates things that are probably numbers into the correct base'
end
