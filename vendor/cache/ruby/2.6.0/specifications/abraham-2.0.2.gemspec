# -*- encoding: utf-8 -*-
# stub: abraham 2.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "abraham".freeze
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Abbett".freeze]
  s.date = "2019-10-18"
  s.description = "Trackable application tours for Rails with i18n support, based on Shepherd.js.".freeze
  s.email = ["jonathan@act.md".freeze]
  s.homepage = "https://github.com/actmd/abraham".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Trackable application tours for Rails with i18n support, based on Shepherd.js.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<sassc-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<listen>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sassc-rails>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<listen>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sassc-rails>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<listen>.freeze, [">= 0"])
  end
end
