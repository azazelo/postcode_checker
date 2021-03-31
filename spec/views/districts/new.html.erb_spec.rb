# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'districts/new.html.erb', type: :view do
  before(:each) do
    assign(:district, [
             District.new
           ])
  end

  it 'displays both districts' do
    render
    expect(rendered).to match(/Add District/)
  end
end
