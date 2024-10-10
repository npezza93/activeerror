# frozen_string_literal: true

module ActiveError
  class FaultsController < ApplicationController
    before_action :set_fault, only: %i(show destroy)

    def index
      @faults = Fault.top_level.includes(:instances)
    end

    def show
      instance = @fault.instances.last ||
        @fault.instances.new(headers: {}, parameters: {})

      render html: Renderer.new(instance:).body
    end

    def destroy
      @fault.destroy

      redirect_to faults_url, notice: "Exception was resolved"
    end

    private

    def set_fault
      @fault = Fault.find(params[:id])
    end
  end
end
