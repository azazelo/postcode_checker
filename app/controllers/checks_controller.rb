# frozen_string_literal: true

class ChecksController < ApplicationController
  def checking
    @check = Check.new
  end

  def perform
    @check = Check.new(value: check_params[:string])
    if @check.valid?
      @check.perform_check
      message = @check.messages.join('<br/>')
      redirect_to checking_path,
                  flash: { now: message, alert_class: _alert_class }
    else
      message = @check.errors.full_messages.join('<br/>')
      redirect_to checking_path,
                  flash: { now: message, alert_class: 'danger' }
    end
  end

  private

  def _alert_class
    @check.allowed ? 'success' : 'danger'
  end

  def check_params
    params.permit(:string)
  end
end
