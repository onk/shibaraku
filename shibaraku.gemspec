$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shibaraku/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shibaraku"
  s.version     = Shibaraku::VERSION
  s.authors     = ["Takafumi ONAKA"]
  s.email       = ["takafumi.onaka@gmail.com"]
  s.homepage    = "https://github.com/onk/shibaraku"
  s.summary     = "Manage model with a period on ActiveRecord."
  s.description = "Manage model with a period on ActiveRecord."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"

  s.add_development_dependency "mysql2"
end
