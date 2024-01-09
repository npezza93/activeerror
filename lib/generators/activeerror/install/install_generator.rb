# frozen_string_literal: true

class ActiveError::InstallGenerator < Rails::Generators::Base
  def add_route
    route "mount ActiveError::Engine => \"/active_error\""
  end

  def create_migrations
    rails_command "active_error:install:migrations", inline: true
  end
end
