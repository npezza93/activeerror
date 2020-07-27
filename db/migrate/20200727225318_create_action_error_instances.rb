# frozen_string_literal: true

class CreateActionErrorInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :action_error_instances do |t|
      t.belongs_to :fault
      t.string :url
      t.text :headers
      t.text :parameters

      t.timestamps
    end
  end
end
