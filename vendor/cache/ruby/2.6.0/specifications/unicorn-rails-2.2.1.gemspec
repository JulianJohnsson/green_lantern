# -*- encoding: utf-8 -*-
# stub: unicorn-rails 2.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "unicorn-rails".freeze
  s.version = "2.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Samuel Kadolph".freeze]
  s.date = "2016-07-12"
  s.description = "unicorn-rails overrides the Rack::Handler.default method to return Rack::Handler::Unicorn which will cause rack (and rails) to use unicorn by default.".freeze
  s.email = ["samuel@kadolph.com".freeze]
  s.homepage = "https://github.com/samuelkadolph/unicorn-rails".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "3.0.4".freeze
  s.summary = "unicorn-rails is a simple gem that sets the default server for rack (and rails) to unicorn.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<unicorn>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 0"])
      s.add_dependency(%q<unicorn>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<unicorn>.freeze, [">= 0"])
  end
end
