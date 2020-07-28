# frozen_string_literal: true

module ActionError
  class FaultsController < ApplicationController
    before_action :set_fault, only: %i(show destroy)

    def index
      @faults = ActionError::Fault.top_level
    end

    def show
    end

    def destroy
      @fault.destroy

      redirect_to faults_url, notice: "Exception was resolved"
    end

    private

    def set_fault
      @fault = ActionError::Fault.find(params[:id])
    end
  end
end
