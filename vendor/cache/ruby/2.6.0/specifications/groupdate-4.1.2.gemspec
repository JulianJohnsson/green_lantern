# -*- encoding: utf-8 -*-
# stub: groupdate 4.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "groupdate".freeze
  s.version = "4.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Kane".freeze]
  s.date = "2019-05-27"
  s.email = "andrew@chartkick.com".freeze
  s.homepage = "https://github.com/ankane/groupdate".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "3.0.4".freeze
  s.summary = "The simplest way to group temporal data".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<activerecord>.freeze, [">= 0"])
      s.add_development_dependency(%q<pg>.freeze, ["< 1"])
      s.add_development_dependency(%q<mysql2>.freeze, ["< 0.5"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3.0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 4.2"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<activerecord>.freeze, [">= 0"])
      s.add_dependency(%q<pg>.freeze, ["< 1"])
      s.add_dependency(%q<mysql2>.freeze, ["< 0.5"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3.0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, ["< 1"])
    s.add_dependency(%q<mysql2>.freeze, ["< 0.5"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3.0"])
  end
end
