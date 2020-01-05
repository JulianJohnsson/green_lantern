# -*- encoding: utf-8 -*-
# stub: datetime_picker_rails 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "datetime_picker_rails".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Grayson Wright".freeze]
  s.date = "2016-01-20"
  s.description = "This gem packages the Bootstrap3 bootstrap-datetimepicker (JS + CSS) for Rails 3.1+ asset pipeline.".freeze
  s.email = ["wright.grayson@gmail.com".freeze]
  s.homepage = "http://github.com/graysonwright/datetime_picker_rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Bootstrap3 bootstrap-datetimepicker\"s JS + CSS for Rails 3.1+ asset pipeline.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 2.8.1"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<momentjs-rails>.freeze, [">= 2.8.1"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<momentjs-rails>.freeze, [">= 2.8.1"])
  end
end
