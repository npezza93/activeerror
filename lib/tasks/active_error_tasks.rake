# frozen_string_literal: true

desc "Copy over the migrations and mount route for ActiveError"
namespace :active_error do
  task :install do
    Rails::Command.invoke :generate, [ "active_error:install" ]
  end
end
