require 'rails_helper'

RSpec.describe Check, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_uniqueness_of(:value) }
  
  let!(:postcode) { Postcode.create(value: 'S24 1AA') }
  let!(:check) { Check.new(value: 'S24 1AA') }
  it '#perform', :aggregate_failures do    
    check.perform
    expect(check.messages).to be_a(Array)
    expect(check.messages).to include(/ALLOWED/)
  end
  
  it 'saved to DB' do
    Check.create(value: 'SH24 1AA')
    expect(Check.count).to eq 1
  end

  it 'deleted from DB' do
    Check.create(value: 'SH24 1AA')
    Check.last.delete
    expect(Check.count).to eq 0
  end

end
