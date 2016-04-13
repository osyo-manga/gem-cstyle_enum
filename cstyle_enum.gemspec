# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cstyle_enum/version'

Gem::Specification.new do |spec|
  spec.name          = "cstyle_enum"
  spec.version       = CstyleEnum::VERSION
  spec.authors       = ["osyo-manga"]
  spec.email         = ["osyo.manga@gmail.com"]

  spec.summary       = %q{C style enum.}
  spec.description   = %q{C style enum.}
  spec.homepage      = "https://github.com/osyo-manga/gem-cstyle_enum"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
