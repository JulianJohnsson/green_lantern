# -*- encoding: utf-8 -*-
# stub: mailjet 1.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "mailjet".freeze
  s.version = "1.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tyler Nappy".freeze, "Jean-Baptiste Escoyez".freeze, "Aur\u00E9lien AMILIN".freeze, "Benoit B\u00E9n\u00E9zech".freeze]
  s.date = "2017-07-03"
  s.description = "Ruby wrapper for Mailjet's v3 API".freeze
  s.email = ["tyler@mailjet.com".freeze, "devrel-team@mailjet.com".freeze, "jbescoyez@gmail.com".freeze]
  s.homepage = "http://www.mailjet.com".freeze
  s.post_install_message = "\n  The Ruby wrapper for Mailjet has just been installed successfully, congrats!\n  Maybe you want to configure your credentials to use your account.\n  All informations available on https://github.com/mailjet/mailjet-gem.\n  But if you are using Rails, you'll be glad to generate it easily using:\n\n    $ rails generate mailjet:initializer\n\n  We hope you will enjoy Mailjet!\n\n".freeze
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Mailjet a powerful all-in-one email service provider clients can use to get maximum insight and deliverability results from both their marketing and transactional emails. Our analytics tools and intelligent APIs give senders the best understanding of how to maximize benefits for each individual contact, with each email sent.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.1.0"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.4.0"])
      s.add_runtime_dependency(%q<rest-client>.freeze, [">= 0"])
      s.add_development_dependency(%q<actionmailer>.freeze, [">= 3.0.9"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest-matchers>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest-spec-context>.freeze, [">= 0"])
      s.add_development_dependency(%q<turn>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_development_dependency(%q<guard>.freeze, [">= 0"])
      s.add_development_dependency(%q<guard-minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_development_dependency(%q<dotenv>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.1.0"])
      s.add_dependency(%q<rack>.freeze, [">= 1.4.0"])
      s.add_dependency(%q<rest-client>.freeze, [">= 0"])
      s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.9"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<minitest-matchers>.freeze, [">= 0"])
      s.add_dependency(%q<minitest-spec-context>.freeze, [">= 0"])
      s.add_dependency(%q<turn>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_dependency(%q<guard>.freeze, [">= 0"])
      s.add_dependency(%q<guard-minitest>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_dependency(%q<dotenv>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.1.0"])
    s.add_dependency(%q<rack>.freeze, [">= 1.4.0"])
    s.add_dependency(%q<rest-client>.freeze, [">= 0"])
    s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.9"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<minitest-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<minitest-spec-context>.freeze, [">= 0"])
    s.add_dependency(%q<turn>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<guard-minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
    s.add_dependency(%q<dotenv>.freeze, [">= 0"])
  end
end
