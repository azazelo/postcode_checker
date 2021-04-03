# frozen_string_literal: true

require_relative './system_helper'

describe 'User interface', :aggregate_failures do
  @submit_button_text = 'Add District to Allowed Districts list'

  feature 'Save postcode to allowed districts list', %(
    To save district as a User I want to be able to enter district name
    in text_field and click on button [#{@submit_button_text}]
  ) do
    let(:district_name) { 'Southwark' }

    scenario 'User type district name in text_field and click on Submit button', :web_ui do
      visit new_district_path
      expect(page).to have_content 'Add Allowed District'
      page.fill_in 'district[name]', with: district_name
      click_button @submit_button_text
      expect(page).to have_content "District '#{district_name}' Saved"
    end

    scenario 'User wants to see Allowed Districts', :web_ui do
      visit districts_path
      expect(page).to have_content 'Allowed Districts'
      click_link 'Add District'
      expect(page).to have_content 'Add Allowed District'
    end
  end
end
