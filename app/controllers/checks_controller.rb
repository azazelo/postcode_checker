require 'pry'
class ChecksController < ApplicationController
  def new
    @obj = Check.new
  end

  def create
    @check = Check.new(check_params)
    allowness = @check.allowed? ? 'ALLOWED' : 'NOT allowed'
    message = "Postcode '#{@check.value}' is #{allowness}"
    
    redirect_to new_check_path, flash: {now: message}
  end
  
  private
  
  def check_params
    params.require(:check).permit(:value)
  end
  
end
