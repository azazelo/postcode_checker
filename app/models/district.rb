# frozen_string_literal: true

# Model to keep allowed districts
#
class District < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  after_validation do
    self.name = name.to_s.strip.capitalize.gsub(' ', '')
  end
end
