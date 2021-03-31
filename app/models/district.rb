# frozen_string_literal: true

class District < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  after_validation do
    self.name = name.to_s.strip.capitalize.gsub(' ', '')
  end
end
