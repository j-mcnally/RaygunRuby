# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'RaygunRuby/version'

Gem::Specification.new do |gem|
  gem.name          = "RaygunRuby"
  gem.version       = RaygunRuby::VERSION
  gem.authors       = ["j-mcnally"]
  gem.email         = ["justin@kohactive.com"]
  gem.description   = "Raygun api implementation for rails"
  gem.summary       = "Allows usage of raygun and rails"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "thor"
  gem.add_runtime_dependency "faraday"
  gem.add_runtime_dependency "awesome_print"

end
