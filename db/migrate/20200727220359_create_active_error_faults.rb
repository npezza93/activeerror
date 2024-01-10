# frozen_string_literal: true

class CreateActiveErrorFaults < ActiveRecord::Migration[7.1]
  def change
    create_table :active_error_faults do |t|
      t.belongs_to :cause
      t.binary :backtrace, lmit: 512.megabytes
      t.binary :backtrace_locations, lmit: 512.megabytes
      t.string :klass
      t.text :message
      t.string :controller
      t.string :action
      t.integer :instances_count
      t.text :blamed_files, lmit: 512.megabytes
      t.text :options
      t.index %i(klass backtrace message)

      t.timestamps
    end
  end
end
