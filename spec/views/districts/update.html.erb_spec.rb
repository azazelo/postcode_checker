# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'districts/update.html.erb', type: :view do
  before(:each) do
    assign(:district, [
             District.create(name: 'District')
           ])
  end

  it 'displays district' do
    render
    expect(rendered).to match(/District/)
  end
end
