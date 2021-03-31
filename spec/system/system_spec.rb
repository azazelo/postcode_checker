# frozen_string_literal: true

require_relative './system_helper'
require_relative '../support/navigation_link_spec'

describe 'User interface', :aggregate_failures do
  feature 'Navigate to pages', %(
    To use application as a User I want to be able navigate to pages by clicking
links] ) do
    before do
      visit root_path
    end
    it_behaves_like 'Navigation link', 'Check postcode', 'Postcode'
    it_behaves_like 'Navigation link', 'Allowed postcodes', 'Allowed Postcodes'
    it_behaves_like 'Navigation link', 'Allowed districts', 'Allowed Districts'
    #    it_behaves_like 'Navigation link', @link_3, 'Allowed Districts'
  end
end
