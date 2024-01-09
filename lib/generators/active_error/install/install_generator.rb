# frozen_string_literal: true

class ActiveError::InstallGenerator < Rails::Generators::Base
  def add_route
    route "mount ActiveError::Engine => \"/active_error\""
  end

  def create_migrations
    rails_command "railties:install:migrations FROM=activeerror", inline: true
  end
end
