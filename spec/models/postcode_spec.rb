require 'rails_helper'

RSpec.describe Postcode, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_uniqueness_of(:value) }
  
  it 'saved to DB' do
    Postcode.create(value: 'SH24 1AA')
    expect(Postcode.count).to eq 1
  end

  it 'deleted from DB' do
    Postcode.create(value: 'SH24 1AA')
    Postcode.last.delete
    expect(Postcode.count).to eq 0
  end
end
