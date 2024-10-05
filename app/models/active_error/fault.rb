# frozen_string_literal: true

module ActiveError
  class Fault < ApplicationRecord
    self.filter_attributes = [:backtrace]

    has_one :parent_cause, class_name: "ActiveError::Fault",
                           foreign_key: :cause_id, inverse_of: :cause,
                           dependent: :restrict_with_error
    belongs_to :cause, optional: true, class_name: "ActiveError::Fault",
                       dependent: :destroy
    has_many :instances, dependent: :delete_all

    store :options, accessors: [:template], coder: YAML,
                    yaml: { unsafe_load: true }

    serialize :backtrace, type: Array, coder: YAML
    serialize :backtrace_locations, type: Array, coder: YAML,
                                    yaml: { unsafe_load: true }
    serialize :blamed_files, type: Array, coder: YAML

    scope :top_level, -> { where.missing(:parent_cause) }

    def exception
      ExceptionMock.make(fault: self)
    end

    def title
      "#{klass}#{controller_display}#{action_display}"
    end

    def occurrences
      "#{instances_count} #{'instance'.pluralize(instances_count)}"
    end

    def template
      Marshal.load(super) unless super.nil? # rubocop:disable Security/MarshalLoad
    end

    def template=(new_template)
      super(Marshal.dump(new_template))
    end

    def location
      Rails.backtrace_cleaner.clean(backtrace).first
    end

    private

    def controller_display
      return unless controller?

      " in #{controller.camelize}Controller"
    end

    def action_display
      return unless action? && controller?

      "##{action}"
    end
  end
end
