# frozen_string_literal: true

module ActionError
  class Fault < ApplicationRecord
    has_one :parent_cause, class_name: "ActionError::Fault",
                           foreign_key: :cause_id, inverse_of: :cause,
                           dependent: :restrict_with_error
    belongs_to :cause, optional: true, class_name: "ActionError::Fault",
                       dependent: :destroy
    has_many :instances, dependent: :destroy

    serialize :backtrace, Array
    serialize :blamed_files, Array
    serialize :extras, Hash

    scope :top_level, lambda {
      left_joins(:parent_cause).where(
        parent_causes_action_error_faults: { id: nil }
      )
    }

    def exception
      ExceptionMock.make(fault: self)
    end

    def title
      str = klass
      str += " in #{controller_display}" if controller?
      str += "##{action}" if action?

      str
    end

    def occurrences
      "#{instances_count} #{'instance'.pluralize(instances_count)}"
    end

    private

    def controller_display
      return unless controller?

      "#{controller.camelize}Controller"
    end

  end
end
