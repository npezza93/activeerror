# frozen_string_literal: true

module ActiveError
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    connects_to(**ActiveError.connects_to) if ActiveError.connects_to
  end
end
