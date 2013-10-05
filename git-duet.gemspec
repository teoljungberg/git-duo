# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/duet/version'

Gem::Specification.new do |spec|
  spec.name          = "git-duet"
  spec.version       = Git::Duet::VERSION
  spec.authors       = ["Teo Ljungberg"]
  spec.email         = ["teo.ljungberg@gmail.com"]
  spec.description   = %q{A git porcelain for duet programming. Changes git-config's user.name and user.email settings so you can commit as more than one author.}
  spec.summary       = %q{Git pairing made easy}
  spec.homepage      = "https://github.com/teoljungberg/git-duet"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry", "~> 0.9"
end
