# frozen_string_literal: true

module ActionError
  module Faults
    class InstancesController < ApplicationController
      def show
        render html: Renderer.new(instance:).body
      end

      private

      def instance
        Instance.find_by(fault_id: params[:fault_id], id: params[:id])
      end
    end
  end
end
