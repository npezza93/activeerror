# frozen_string_literal: true

class CreateActiveErrorInstances < ActiveRecord::Migration[7.1]
  def change
    create_table :active_error_instances do |t|
      t.belongs_to :fault
      t.string :url
      t.binary :headers, limit: 512.megabytes
      t.binary :parameters, limit: 512.megabytes

      t.timestamps
    end
  end
end
