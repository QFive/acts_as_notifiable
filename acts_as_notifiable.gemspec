$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_notifiable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_notifiable"
  s.version     = ActsAsNotifiable::VERSION
  s.authors     = ["Damian Galarza"]
  s.email       = ["damian@qfive.com"]
  s.homepage    = "http://github.com/QFive/acts_as_notifiable"
  s.summary     = "Flexible notification system for Rails"
  s.description = "Flexibile notification system for Rails"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "ammeter"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "fuubar"
end
