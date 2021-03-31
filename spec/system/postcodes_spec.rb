# frozen_string_literal: true

require_relative './system_helper'

describe 'User interface', :aggregate_failures do
  @submit_button_text = 'Add Postcode to Allowed Postcodes list'

  feature 'Save postcode to allowed postcodes list', %(
    To save postcode as a User I want to be able to enter postcode in text_field and click on button [#{@submit_button_text}]
  ) do
    let(:postcode_value) { 'SE17QD' }

    scenario 'User type postcode in text_field and click on Submit button', :web_ui do
      visit new_postcode_path
      expect(page).to have_content 'Add Postcode'
      page.fill_in 'postcode[value]', with: postcode_value
      click_button @submit_button_text
      expect(page).to have_content "Postcode '#{postcode_value}' Saved"
    end

    scenario 'User wants to see Allowed Postcodes', :web_ui do
      visit postcodes_path
      expect(page).to have_content 'Allowed Postcodes'
      click_link 'Add Postcode'
      expect(page).to have_content 'Add Postcode'
    end

    scenario 'User inputs invalid postcode and wants
              to see error message', :web_ui do
      visit new_postcode_path
      expect(page).to have_content 'Add Postcode'
      page.fill_in 'postcode[value]', with: '111'
      click_button 'Add Postcode to White List'
      expect(page).to have_content 'Value Only UK postcodes allowed.'
    end
  end
end
