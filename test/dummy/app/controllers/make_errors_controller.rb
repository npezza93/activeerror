# frozen_string_literal: true

class MakeErrorsController < ApplicationController
  def new
    session[:session_id] = "thing"
    raise StandardError, "A new error"
  end
end
