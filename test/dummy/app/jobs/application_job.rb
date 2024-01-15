# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  self.queue_adapter = :solid_queue
end
