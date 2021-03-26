class PostcodesController < ApplicationController
  def new
    @postcode = Postcode.new
  end
  
  def create
    postcode = Postcode.new(postcode_params)
    if postcode.save
      message = "Postcode '#{postcode.value}' Saved"
      redirect_to postcodes_path, flash: {now: message}
    else
      render :new
    end
  end
  
  def index
    @postcodes = Postcode.all 
  end
  
  private 
  
  def postcode_params
    params.require(:postcode).permit(:value)
  end
end
