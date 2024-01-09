# frozen_string_literal: true

class ActiveError::InstallGenerator < Rails::Generators::Base
  def add_route
    route "mount ActiveError::Engine => \"/errors\""
  end

  def create_migrations
    rails_command "active_error:install:migrations", inline: true
  end
end
