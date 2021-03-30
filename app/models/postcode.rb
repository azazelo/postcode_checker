# frozen_string_literal: true

class Postcode < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  before_validation do
    self.value = value.strip.upcase.gsub(' ', '')
  end
end
