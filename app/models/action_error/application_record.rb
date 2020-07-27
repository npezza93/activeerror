# frozen_string_literal: true

module ActionError
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
