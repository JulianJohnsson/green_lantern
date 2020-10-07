# -*- encoding: utf-8 -*-
# stub: thwait 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "thwait".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Keiju ISHITSUKA".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-07-16"
  s.description = "Watches for termination of multiple threads.".freeze
  s.email = ["keiju@ruby-lang.org".freeze]
  s.homepage = "https://github.com/ruby/thwait".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Watches for termination of multiple threads.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<e2mmap>.freeze, [">= 0"])
    else
      s.add_dependency(%q<e2mmap>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<e2mmap>.freeze, [">= 0"])
  end
end
