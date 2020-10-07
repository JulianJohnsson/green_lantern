# -*- encoding: utf-8 -*-
# stub: rb-gsl 1.16.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "rb-gsl".freeze
  s.version = "1.16.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yoshiki Tsunesada".freeze, "David MacMahon".freeze, "Jens Wille".freeze, "Daniel Mendler".freeze]
  s.date = "2015-07-03"
  s.description = "Ruby/GSL is a Ruby interface to the GNU Scientific Library, for numerical computing with Ruby".freeze
  s.email = "mail@daniel-mendler.de".freeze
  s.homepage = "http://github.com/SciRuby/rb-gsl".freeze
  s.licenses = ["GPL-2.0".freeze]
  s.post_install_message = "rb-gsl has been replaced by gsl".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.requirements = ["GSL (http://www.gnu.org/software/gsl/)".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Ruby interface to the GNU Scientific Library".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gsl>.freeze, [">= 0"])
    else
      s.add_dependency(%q<gsl>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<gsl>.freeze, [">= 0"])
  end
end
