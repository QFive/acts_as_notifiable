$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_notifiable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_notifiable"
  s.version     = ActsAsNotifiable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActsAsNotifiable."
  s.description = "TODO: Description of ActsAsNotifiable."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "rspec"
  s.add_development_dependency "ammeter"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "shoulda"
end
