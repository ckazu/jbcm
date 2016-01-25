# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jbcm/version'

Gem::Specification.new do |spec|
  spec.name          = "jbcm"
  spec.version       = Jbcm::VERSION
  spec.authors       = ["CHINDA, Kazuyuki"]
  spec.email         = ["ckazuyuki@gmail.com"]
  spec.summary       = "Jenkins job's build command manager"
  spec.description   = ""
  spec.homepage      = "https://github.com/ckazu/jbcm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '>= 0.9.1'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
