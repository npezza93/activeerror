# frozen_string_literal: true

class CreateActiveErrorFaults < ActiveRecord::Migration[7.1]
  def change
    create_table :active_error_faults do |t|
      t.belongs_to :cause
      t.text :backtrace
      t.text :backtrace_locations
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
