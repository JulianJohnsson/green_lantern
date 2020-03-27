# -*- encoding: utf-8 -*-
# stub: voight_kampff 1.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "voight_kampff".freeze
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Crownoble".freeze]
  s.date = "2020-03-03"
  s.description = "Voight-Kampff detects bots, spiders, crawlers and replicants".freeze
  s.email = "adam@codenoble.com".freeze
  s.homepage = "https://github.com/biola/Voight-Kampff".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Voight-Kampff bot detection".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.4", "< 3.0"])
      s.add_development_dependency(%q<combustion>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 5.2"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.8"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 1.4", "< 3.0"])
      s.add_dependency(%q<combustion>.freeze, ["~> 1.1"])
      s.add_dependency(%q<rails>.freeze, ["~> 5.2"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.8"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 1.4", "< 3.0"])
    s.add_dependency(%q<combustion>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rails>.freeze, ["~> 5.2"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.8"])
  end
end
