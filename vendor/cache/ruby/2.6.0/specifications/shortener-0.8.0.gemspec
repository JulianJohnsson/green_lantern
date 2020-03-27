# -*- encoding: utf-8 -*-
# stub: shortener 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "shortener".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new("> 2.1.0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James P. McGrath".freeze, "Michael Reinsch".freeze]
  s.date = "2018-07-27"
  s.description = "Shortener is a Rails Engine Gem that makes it easy to create and interpret shortened URLs on your own domain from within your Rails application. Once installed Shortener will generate, store URLS and \"unshorten\" shortened URLs for your applications visitors, all whilst collecting basic usage metrics.".freeze
  s.email = ["gems@jamespmcgrath.com".freeze, "michael@mobalean.com".freeze]
  s.homepage = "http://jamespmcgrath.com/projects/shortener".freeze
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Shortener is a Rails Engine that makes it easy to create shortened URLs for your rails application.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<voight_kampff>.freeze, ["~> 1.1.2"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.6.0"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
      s.add_development_dependency(%q<faker>.freeze, [">= 0"])
      s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    else
      s.add_dependency(%q<voight_kampff>.freeze, ["~> 1.1.2"])
      s.add_dependency(%q<rails>.freeze, [">= 3"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.6.0"])
      s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
      s.add_dependency(%q<faker>.freeze, [">= 0"])
      s.add_dependency(%q<byebug>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<voight_kampff>.freeze, ["~> 1.1.2"])
    s.add_dependency(%q<rails>.freeze, [">= 3"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.6.0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
