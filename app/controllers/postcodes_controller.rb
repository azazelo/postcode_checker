class PostcodesController < ApplicationController
  def new
    @postcode = Postcode.new
  end
  
  def create
    @postcode = Postcode.new(postcode_params)
    if @postcode.save
      message = "Postcode '#{@postcode.value}' Saved"
      redirect_to postcodes_path, flash: {now: message, alert_class: 'success'}
    else
      redirect_to new_postcode_path, flash: {now: @postcode.errors.full_messages.join('. '), alert_class: 'danger' }
    end
  end
  
  def index
    @postcodes = Postcode.all 
  end
  
  def destroy
    @postcode = Postcode.find(params[:id])
    if @postcode.delete
      message = "#{@postcode.value} has been succesfully deleted."
      alert_class = 'success'
    else
      message = "#{@postcode.value} has not been deleted. Something wrong."
      alert_class = 'danger'
    end
    redirect_to postcodes_path, flash: {now: message, alert_class: alert_class}
  end
  
  
  private 
  
  def postcode_params
    params.require(:postcode).permit(:value, :id)
  end
end
