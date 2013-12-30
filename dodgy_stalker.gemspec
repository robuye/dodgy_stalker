# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dodgy_stalker/version'

Gem::Specification.new do |spec|
  spec.name          = "dodgy_stalker"
  spec.version       = DodgyStalker::VERSION
  spec.authors       = ["robuye"]
  spec.email         = ["rulejczyk@gmail.com"]
  spec.description   = %q{Filters to detect spam, trolls and unwanted content}
  spec.summary       = %q{Filters to detect spam, trolls and unwanted content}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "database_cleaner"

  spec.add_dependency "activerecord", "~> 4.0.0"
  spec.add_dependency "typhoeus"
  spec.add_dependency "addressable"
end
