$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shibaraku/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shibaraku"
  s.version     = Shibaraku::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Shibaraku."
  s.description = "TODO: Description of Shibaraku."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.7"

  s.add_development_dependency "mysql2"
end
