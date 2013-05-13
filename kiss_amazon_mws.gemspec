# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kiss_amazon_mws/version'

Gem::Specification.new do |spec|
  spec.name          = "kiss_amazon_mws"
  spec.version       = KissAmazonMws::VERSION
  spec.authors       = ["drKreso"]
  spec.email         = ["kresimir.bojcic@gmail.com"]
  spec.description   = %q{Sending updates to Amazon Marketplace Web Service}
  spec.summary       = %q{Just plugin Amazon account secrets and go!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
