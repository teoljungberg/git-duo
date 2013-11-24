# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/duo/version'

Gem::Specification.new do |spec|
  spec.name          = "git-duo"
  spec.version       = Git::Duo::VERSION
  spec.authors       = ["Teo Ljungberg"]
  spec.email         = ["teo.ljungberg@gmail.com"]
  spec.description   = %q{A git porcelain for duo programming. Changes git-config's user.name and user.email settings so you can commit as more than one author.}
  spec.summary       = %q{Git pairing made easy}
  spec.homepage      = "https://github.com/teoljungberg/git-duo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
end
