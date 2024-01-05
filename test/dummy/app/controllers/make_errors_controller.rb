# frozen_string_literal: true

class MakeErrorsController < ApplicationController
  def new
    raise StandardError, "A new error"
  end
end
