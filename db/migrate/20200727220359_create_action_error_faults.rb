# frozen_string_literal: true

class CreateActionErrorFaults < ActiveRecord::Migration[6.0]
  def change
    create_table :action_error_faults do |t|
      t.belongs_to :cause
      t.text :backtrace
      t.string :klass
      t.text :message
      t.string :controller
      t.string :action
      t.integer :instances_count
      t.text :blamed_files
      t.text :options
      t.index %i(klass backtrace message)

      t.timestamps
    end
  end
end
