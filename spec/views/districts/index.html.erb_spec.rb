# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'districts/index.html.erb', type: :view do
  before(:each) do
    assign(:districts, [
             District.create!(name: 'District1'),
             District.create!(name: 'District2')
           ])
  end

  it 'displays both districts' do
    render

    expect(rendered).to match(/District1/)
    expect(rendered).to match(/District2/)
  end
end
