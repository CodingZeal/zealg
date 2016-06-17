# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zealg/version'
require "zealg/boilerplate"

Gem::Specification.new do |spec|
  spec.name          = "zealg"
  spec.version       = Zealg::VERSION
  spec.authors       = ["Julian Rogmans"]
  spec.email         = ["julian.rogmans@codingzeal.com"]

  spec.summary       = %q{Generate an install zeal tools and projects into a rails app}
  spec.description   = %q{Something about how to use this gem}
  spec.homepage      = "https://www.github.com/CodingZeal/zealg"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '0.19.1'
  spec.add_runtime_dependency 'git', '1.3.0'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
