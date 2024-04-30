# -*- encoding: utf-8 -*-
# stub: brewfile 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "brewfile".freeze
  s.version = "1.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jake Meyer".freeze]
  s.date = "2018-03-04"
  s.email = ["jakewmeyer@gmail.com".freeze]
  s.executables = ["brewfile".freeze]
  s.files = ["bin/brewfile".freeze]
  s.homepage = "https://github.com/jakewmeyer/Brewfile-Generator".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.21".freeze
  s.summary = "Generates a Homebrew Brewfile from currently installed formula for easy backup".freeze

  s.installed_by_version = "3.4.21".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
end
