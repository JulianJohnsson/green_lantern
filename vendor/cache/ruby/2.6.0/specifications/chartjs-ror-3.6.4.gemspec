# -*- encoding: utf-8 -*-
# stub: chartjs-ror 3.6.4 ruby lib

Gem::Specification.new do |s|
  s.name = "chartjs-ror".freeze
  s.version = "3.6.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Stewart".freeze]
  s.date = "2019-02-27"
  s.description = "Simplifies using Chart.js in Rails".freeze
  s.email = ["boss@airbladesoftware.com".freeze]
  s.homepage = "https://github.com/airblade/chartjs-ror".freeze
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Simplifies using Chart.js in Rails".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
