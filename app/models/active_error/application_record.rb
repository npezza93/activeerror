# frozen_string_literal: true

module ActiveError
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
