# frozen_string_literal: true

require 'rails_helper'

RSpec.describe District, type: :model do
  it { should validate_presence_of(:name) }
  subject { District.new(name: 'Distinct') }
  it { should validate_uniqueness_of(:name) }

  it 'saved to DB' do
    District.create(name: 'Distinct')
    expect(District.count).to eq 1
  end

  it 'deleted from DB' do
    District.create(name: 'Distinct')
    District.last.delete
    expect(District.count).to eq 0
  end
end
