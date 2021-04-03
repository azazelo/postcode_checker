# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Postcode, type: :model do
  it { should validate_presence_of(:value) }
  subject { Postcode.new(value: 'SH241AX') }
  it { should validate_uniqueness_of(:value).ignoring_case_sensitivity }

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
