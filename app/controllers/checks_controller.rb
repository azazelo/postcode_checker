# frozen_string_literal: true

# ChecksController
#   manage checking
#
class ChecksController < ApplicationController
  def checking
    @check = Check.new
  end

  def perform
    @check = Check.new(value: check_params[:string])
    messages, alert_class =
      if @check.valid?
        @check.perform_check
        [@check.ch_messages, _alert_class(@check.ch_allowed)]
      else
        [@check.errors.full_messages.join('<br/>'), _alert_class(false)]
      end
    redirect_to checking_path, flash: { now: messages, alert_class: alert_class }
  end

  private

  def _alert_class(cond)
    cond ? 'success' : 'danger'
  end

  def check_params
    params.permit(:string)
  end
end
