# -*- encoding: utf-8 -*-
# stub: analytics-ruby 2.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "analytics-ruby".freeze
  s.version = "2.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Segment.io".freeze]
  s.date = "2015-09-10"
  s.description = "The Segment.io ruby analytics library".freeze
  s.email = "friends@segment.io".freeze
  s.homepage = "https://github.com/segmentio/analytics-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Segment.io analytics library".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.3"])
      s.add_development_dependency(%q<wrong>.freeze, ["~> 0.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<tzinfo>.freeze, ["= 1.2.1"])
      s.add_development_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 4.0.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 10.3"])
      s.add_dependency(%q<wrong>.freeze, ["~> 0.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_dependency(%q<tzinfo>.freeze, ["= 1.2.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 4.0.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 10.3"])
    s.add_dependency(%q<wrong>.freeze, ["~> 0.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
    s.add_dependency(%q<tzinfo>.freeze, ["= 1.2.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0", "< 4.0.0"])
  end
end
