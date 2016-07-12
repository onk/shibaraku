# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shibaraku/version"

Gem::Specification.new do |spec|
  spec.name          = "shibaraku"
  spec.version       = Shibaraku::VERSION
  spec.authors       = ["Takafumi ONAKA"]
  spec.email         = ["takafumi.onaka@gmail.com"]

  spec.summary       = "Manage model with a period on ActiveRecord."
  spec.description   = "Manage model with a period on ActiveRecord."
  spec.homepage      = "https://github.com/onk/shibaraku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rspec"
end
