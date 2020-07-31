# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

require "action_error/version"

Gem::Specification.new do |spec|
  spec.name        = "actionerror"
  spec.version     = ActionError::VERSION
  spec.authors     = ["Nick Pezza"]
  spec.email       = ["pezza@hey.com"]
  spec.homepage    = "https://github.com/npezza93/actionerror"
  spec.summary     = "Rails exception logger"
  spec.license     = "MIT"

  spec.files =
    Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.1"
  spec.add_dependency "useragent"

  spec.add_development_dependency "sqlite3"
end
