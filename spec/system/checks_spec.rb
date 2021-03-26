require_relative './system_helper'

describe 'User interface for postcode checks', :aggregate_failures do
  @submit_button_text = 'Check Postcode'
  
  def allowed_message value
    "Postcode '#{value}' is ALLOWED"
  end
    
  def not_allowed_message value
    "Postcode '#{value}' is NOT ALLOWED"
  end
    
  ##TODO enable prefix 'u' to call show_page method
  feature 'Check postcode', %{
    To check postcode as a User I want to be able to enter postcode in text_field and click on button [#{@submit_button_text}] } do


    let(:allowed_by_postcodes_io) { 'SE1 7QD' }
    scenario 'get message on screen that postcode is ALLOWED' do
      visit new_check_path
      expect(page).to have_content "Check Postcode"
      page.fill_in 'check[value]', with: allowed_by_postcodes_io
      click_button @submit_button_text
      expect(page).to have_content allowed_message(allowed_by_postcodes_io)
      show_page
    end

    let(:not_allowed_by_postcodes_io) { 'RM3 0PD' }
    scenario 'get message on screen that postcode is NOT ALLOWED' do
      pending 'Not yet implemented postcodes_io check'
      
      visit new_check_path
      expect(page).to have_content "Check Postcode"
      page.fill_in 'check[value]', with: not_allowed_by_postcodes_io
      click_button @submit_button_text
      expect(page).to have_content not_allowed_message(not_allowed_by_postcodes_io)
      show_page
    end

    let(:exists_in_white_list) { 'SH24 1AA' }
    scenario 'get message on screen that postcode is NOT ALLOWED' do
      pending 'Not yet implemented white_list check'
      
      visit new_check_path
      expect(page).to have_content "Check Postcode"
      page.fill_in 'check[value]', with: exists_in_white_list
      click_button @submit_button_text
      expect(page).to have_content allowed_message(exists_in_white_list)
      show_page
    end

#    scenario 'User wants to see Allowed Postcodes', :web_ui do
#      visit postcodes_path
#      expect(page).to have_content "Allowed Postcodes"
#      click_link 'Add Postcode'
#      expect(page).to have_content "Add Postcode"

      ## Ucomment show_page if you wants to see resulted browser page.
      ## required of running webserver on localhost:3000
      # show_page
#    end
  end
end
