# frozen_string_literal: true

require_relative './system_helper'

describe 'Save first postcode', :aggregate_failures do
  let(:postcode_value) { 'SH241AA' }

  scenario 'User type postcode in text_field and click on Submit button', :web_ui do
    visit new_postcode_path
    expect(page).to have_content 'Add Postcode'
    page.fill_in 'postcode[value]', with: postcode_value
    click_button add_postcode_button_text
    expect(page).to have_content "Postcode '#{postcode_value}' Saved"
  end
end

describe 'Save existing postcode' do
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
end

describe 'Allowed postcodes list' do
  scenario 'show', :web_ui do
    visit postcodes_path
    expect(page).to have_content 'Allowed Postcodes'
    click_link 'Add Postcode'
    expect(page).to have_content 'Add Postcode'
  end
end

describe 'Save invalid value' do
  scenario 'Invalid postcode and error message', :web_ui do
    visit new_postcode_path
    expect(page).to have_content 'Add Postcode'
    page.fill_in 'postcode[value]', with: '111'
    click_button add_postcode_button_text
    expect(page).to have_content 'Value Only UK postcodes allowed.'
  end
end
