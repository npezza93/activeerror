# frozen_string_literal: true

module ActionError
  class Engine < ::Rails::Engine
    isolate_namespace ActionError
  end
end
