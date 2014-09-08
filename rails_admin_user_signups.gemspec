$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_user_signups/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_user_signups"
  s.version     = RailsAdminUserSignups::VERSION
  s.authors     = ["Seyed Razavi"]
  s.email       = ["seyed@educationapps.co.uk"]
  s.homepage    = "https://github.com/seyedrazavi/rails_admin_user_signups"
  s.summary     = "User signup report for rails admin using Device models"
  s.description = "User signup report for rails admin using Device models"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.4"
end
