# frozen_string_literal: true

class AddSessionToInstances < ActiveRecord::Migration[7.2]
  def change
    add_column :active_error_instances, :session, :binary, limit: 10.megabytes
  end
end
