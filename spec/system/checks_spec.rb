# frozen_string_literal: true

require_relative './system_helper'

describe 'User interface for postcode checks', :aggregate_failures do
  @submit_button_text = 'Check Postcode'

  def allowed_message(value)
    "'#{value}' is ALLOWED"
  end

  def not_allowed_message(value)
    "'#{value}' is NOT allowed"
  end

  # #TODO enable prefix 'u' to call show_page method
  feature 'Check postcode', %(
    To check postcode as a User I want to be able to enter postcode
    in text_field and click on button [#{@submit_button_text}] ) do
    let!(:district1) { District.create(name: 'Southwark') }
    let!(:district2) { District.create(name: 'Lambeth') }

    let(:allowed_by_postcodes_io) { 'SE1 7QD' }
    scenario 'get message on screen that postcode is ALLOWED' do
      visit checking_path
      expect(page).to have_content 'Postcode'
      page.fill_in 'string', with: allowed_by_postcodes_io
      click_button @submit_button_text
      expect(page).to have_content allowed_message(allowed_by_postcodes_io)
    end

    let(:not_allowed_by_postcodes_io) { 'RM3 0PD' }
    scenario 'get message on screen that postcode is NOT allowed' do
      visit checking_path
      expect(page).to have_content 'Postcode'
      page.fill_in 'string', with: not_allowed_by_postcodes_io
      click_button @submit_button_text
      expect(page).to have_content not_allowed_message(not_allowed_by_postcodes_io)
    end

    let!(:exists_in_white_list) { 'SH24 1AA' }
    let!(:postcode) { Postcode.create(value: 'SH24 1AA') }
    scenario 'get message on screen that postcode is NOT allowed' do
      visit checking_path
      expect(page).to have_content 'Postcode'
      page.fill_in 'string', with: exists_in_white_list
      click_button @submit_button_text
      expect(page).to have_content allowed_message(exists_in_white_list)
    end

    scenario 'User wants to manage Allowed Postcodes', :web_ui do
      visit postcodes_path
      expect(page).to have_content 'Allowed Postcodes'
      click_link 'Add Postcode'
      expect(page).to have_content 'Add Postcode'
    end
  end
end
