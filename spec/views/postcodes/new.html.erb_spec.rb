# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'postcodes/new.html.erb', type: :view do
  before(:each) do
    assign(:postcode, [
             Postcode.new
           ])
  end

  it 'displays postcode' do
    render
    expect(rendered).to match(/Add Postcode/)
  end
end
