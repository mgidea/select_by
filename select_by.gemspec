# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'select_by/version'

Gem::Specification.new do |spec|
  spec.name          = "select_by"
  spec.version       = SelectBy::VERSION
  spec.authors       = ["Tom Corley"]
  spec.email         = ["tom@buildinsync.com"]

  spec.summary       = %q{Extends ruby Array class to add new equality filtering methods}
  spec.description   = %q{Extends ruby Array class to add new equality filtering methods select_by, reject_by, detect_by, partition_by}
  spec.homepage      = "https://github.com/mgidea/select_by"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
