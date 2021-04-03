# frozen_string_literal: true

require_relative './system_helper'

describe 'User interface', :aggregate_failures do
  feature 'Save postcode to allowed postcodes list', %(
    To save postcode as a User I want to be able to enter
    postcode in text_field and click on button [#{add_postcode_button_text}]) do
    let(:postcode_value) { 'SH241AA' }

    scenario 'User type postcode in text_field and click on Submit button', :web_ui do
      visit new_postcode_path
      expect(page).to have_content 'Add Postcode'
      page.fill_in 'postcode[value]', with: postcode_value
      click_button add_postcode_button_text
      expect(page).to have_content "Postcode '#{postcode_value}' Saved"
    end

    before do
      Postcode.create(value: 'SH241AB')
    end
    scenario 'User type existing postcode in text_field, click on Submit button', :web_ui do
      visit new_postcode_path
      expect(page).to have_content 'Add Postcode'
      page.fill_in 'postcode[value]', with: 'SH241AB'
      click_button add_postcode_button_text
      expect(page).to have_content 'Value has already been taken'
    end

    scenario 'User wants to see Allowed Postcodes', :web_ui do
      visit postcodes_path
      expect(page).to have_content 'Allowed Postcodes'
      click_link 'Add Postcode'
      expect(page).to have_content 'Add Postcode'
    end

    scenario 'invalid postcode and error message', :web_ui do
      visit new_postcode_path
      expect(page).to have_content 'Add Postcode'
      page.fill_in 'postcode[value]', with: '111'
      click_button add_postcode_button_text
      expect(page).to have_content 'Value Only UK postcodes allowed.'
    end
  end
end
