# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'postcodes/index.html.erb', type: :view do
  before(:each) do
    assign(:postcodes, [
             Postcode.create!(value: 'SH24 1AA'),
             Postcode.create!(value: 'SH24 1AB')
           ])
  end

  it 'displays both postcodes' do
    render

    expect(rendered).to match(/SH241AA/)
    expect(rendered).to match(/SH241AB/)
  end
end
