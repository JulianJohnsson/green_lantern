# -*- encoding: utf-8 -*-
# stub: hub 1.12.4 ruby lib

Gem::Specification.new do |s|
  s.name = "hub".freeze
  s.version = "1.12.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Wanstrath".freeze, "Mislav Marohni\u0107".freeze]
  s.date = "2014-12-25"
  s.description = "  `hub` is a command line utility which adds GitHub knowledge to `git`.\n\n  It can used on its own or as a `git` wrapper.\n\n  Normal:\n\n      $ hub clone rtomayko/tilt\n\n      Expands to:\n      $ git clone git://github.com/rtomayko/tilt.git\n\n  Wrapping `git`:\n\n      $ git clone rack/rack\n\n      Expands to:\n      $ git clone git://github.com/rack/rack.git\n".freeze
  s.email = "mislav.marohnic@gmail.com".freeze
  s.executables = ["hub".freeze]
  s.files = ["bin/hub".freeze]
  s.homepage = "http://hub.github.com/".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\n------------------------------------------------------------\n\n                  You there! Wait, I say!\n                  =======================\n\n       If you are a heavy user of `git` on the command\n       line  you  may  want  to  install `hub` the old\n       fashioned way.  Faster  startup  time,  you see.\n\n       Check  out  the  installation  instructions  at\n       https://github.com/github/hub#readme  under the\n       \"Standalone\" section.\n\n       Cheers,\n       defunkt\n\n------------------------------------------------------------\n\n".freeze
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Command-line wrapper for git and GitHub".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version
end
