# encoding: utf-8
require File.expand_path('../lib/infusionsoft/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'infusionsoft'
  gem.summary = %q{Ruby wrapper for the Infusionsoft API}
  gem.description = 'A Ruby wrapper written for the Infusionsoft API'
  gem.authors = ["Nathan Leavitt"]
  gem.email = ['nateleavitt@gmail.com']
  # gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/nateleavitt/infusionsoft'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.add_development_dependency 'rake'

  gem.version = Infusionsoft::VERSION.dup
end

