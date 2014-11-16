# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hb_exporter/version'

Gem::Specification.new do |spec|
  spec.name          = "hb_exporter"
  spec.version       = HbExporter::VERSION
  spec.authors       = ["如彼"]
  spec.email         = ["hua.qiuh@alibaba-inc.com"]
  spec.summary       = %q{Help you export pictures from huaban.com}
  spec.description   = %q{This gems helps you exporting your pictures from huaban.com.}
  spec.homepage      = "https://github.com/qhwa/huaban_exporter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # for git-like commonad-line
  spec.add_dependency "gli", "~> 2.12.2"

  spec.add_dependency "colored", "~> 1.2"
  spec.add_dependency "ruby-progressbar", "~> 1.7.0"
  spec.add_dependency "httparty", "~> 0.13.3"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

end
