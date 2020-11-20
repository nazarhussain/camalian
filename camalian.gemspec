# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camalian/version'

Gem::Specification.new do |spec|
  spec.name          = 'camalian'
  spec.version       = Camalian::VERSION
  spec.authors       = ['Nazar Hussain']
  spec.email         = ['nazarhussain@gmail.com']
  spec.description   = 'Library used to deal with colors and images'
  spec.summary       = 'Library used to deal with colors and images. You can extract colors from images.'
  spec.homepage      = 'https://github.com/nazarhussain/camalian'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'chunky_png', '~> 1.3', '>= 1.3.14'

  spec.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.2'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'

  spec.required_ruby_version = '>= 2.4'
end
