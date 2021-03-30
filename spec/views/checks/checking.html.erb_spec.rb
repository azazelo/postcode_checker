require 'rails_helper'

RSpec.describe "checks/checking.html.erb", type: :view do
  before(:each) do
    assign(:check, [
      Check.new
    ])
  end

  it "displays title 'Check Postcode'" do
    render
    expect(rendered).to match /Check Postcode/
  end
end
