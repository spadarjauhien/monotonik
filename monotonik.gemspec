# frozen_string_literal: true

require_relative 'lib/monotonik/version'

Gem::Specification.new do |spec|
  spec.name          = 'monotonik'
  spec.version       = Monotonik::VERSION
  spec.authors       = ['Evgeny Garlukovich']
  spec.email         = ['me@evgenygarl.dev']

  spec.summary       = '⏱ Measure elapsed time the right way.'
  spec.description   = 'This gem helps you to measure elapsed time the right way - using monotonic clock.'
  spec.homepage      = 'https://github.com/evgenygarl/elapsed'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 0.79.0'
end
