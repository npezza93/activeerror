# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

require "active_error/version"

Gem::Specification.new do |spec|
  spec.name        = "activeerror"
  spec.version     = ActiveError::VERSION
  spec.authors     = ["Nick Pezza"]
  spec.email       = ["pezza@hey.com"]
  spec.homepage    = "https://github.com/npezza93/activeerror"
  spec.summary     = "Rails exception logger"
  spec.license     = "MIT"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.required_ruby_version = ">= 3.1.0"
  spec.files =
    Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 7.1"
  spec.add_dependency "useragent"
end
