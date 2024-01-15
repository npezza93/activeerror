# frozen_string_literal: true

class ErrorsJob < ApplicationJob
  def perform
    raise StandardError
  end
end
