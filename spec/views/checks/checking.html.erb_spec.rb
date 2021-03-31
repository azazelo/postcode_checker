# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checks/checking.html.erb', type: :view do
  before(:each) do
    assign(:check, [
             Check.new
           ])
  end

  it "displays title 'Postcode'" do
    render
    expect(rendered).to match(/Postcode/)
  end
end
