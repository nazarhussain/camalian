# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camalian/version'

Gem::Specification.new do |spec|
  spec.name          = "camalian"
  spec.version       = Camalian::VERSION
  spec.authors       = ["Nazar Hussain"]
  spec.email         = ["nazarhussain@gmail.com"]
  spec.description   = %q{Library used to deal with colors and images}
  spec.summary       = %q{Library used to deal with colors and images. You can extract colors from images.}
  spec.homepage      = "https://github.com/nazarhussain/camalian"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.requirements  = 'ImageMagick'

  spec.add_dependency "cocaine"
  spec.add_dependency "rmagick", "~> 2.15.4"
  spec.add_dependency "oily_png", "~> 1.2.0"

end
