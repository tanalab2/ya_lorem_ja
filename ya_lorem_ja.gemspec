# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ya_lorem_ja/version'

Gem::Specification.new do |spec|
  spec.name          = "ya_lorem_ja"
  spec.version       = YaLoremJa::VERSION
  spec.authors       = ["kenji tanaka"]
  spec.description   = %q{Yet Another Japanese Lorem Ipsum generator}
  spec.summary       = %q{Yet Another Japanese Lorem Ipsum generator}
  spec.homepage      = "https://github.com/tanalab2/ya_lorem_ja"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
