Gem::Specification.new do |s|
  s.name        = "rin"
  s.version     = '0.0.1'
  s.authors     = ["Josh Cheek"]
  s.email       = ["josh.cheek@gmail.com"]
  s.homepage    = "https://github.com/JoshCheek/rin"
  s.summary     = %q{Make it easier to script with numbers of alternate bases.}
  s.description = %q{bin/lib that overrides inspect on integers to print numbers in a desired base}
  s.license     = "WTFPL"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_development_dependency "rspec", '~> 3.0'
end
