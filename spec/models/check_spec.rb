# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Check, type: :model do
  it { should validate_presence_of(:value) }

  let!(:check) { Check.new(value: 'S24 1AA') }

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
