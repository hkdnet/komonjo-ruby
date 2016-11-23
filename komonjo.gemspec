# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'komonjo/version'

Gem::Specification.new do |spec|
  spec.name          = "komonjo"
  spec.version       = Komonjo::VERSION
  spec.authors       = ["hkdnet"]
  spec.email         = ["hkdnet@users.noreply.github.com"]

  spec.summary       = 'A Slack client wrapper.'
  spec.description   = 'A Slack client wrapper.'
  spec.homepage      = "https://github.com/hkdnet/komonjo-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.9'

  spec.add_dependency "slack-api", "~> 1.1.6"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-power_assert", "~> 0.2.0"
  spec.add_development_dependency "rubocop"
end
