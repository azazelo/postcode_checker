# frozen_string_literal: true

class DistrictsController < ApplicationController
  def new
    @district = District.new
  end

  def create
    @district = District.new(district_params)
    if @district.save
      message = "District '#{@district.name}' Saved"
      redirect_to districts_path, flash: { now: message, alert_class: 'success' }
    else
      redirect_to new_district_path, flash: { now: @district.errors.full_messages.join('. '), alert_class: 'danger' }
    end
  end

  def update; end

  def index
    @districts = District.all
  end

  def destroy
    @district = District.find(params[:id])
    if @district.delete
      message = "#{@district.name} has been succesfully deleted."
      alert_class = 'success'
    else
      message = "#{@district.name} has not been deleted. Something wrong."
      alert_class = 'danger'
    end
    redirect_to districts_path, flash: { now: message, alert_class: alert_class }
  end

  private

  def district_params
    params.require(:district).permit(:name, :id)
  end
end
