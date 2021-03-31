# frozen_string_literal: true

# Model to keep allowed postcodes
#
class Postcode < ApplicationRecord
  validates :value, presence: true, uniqueness: true,
                    format: {
                      with: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i,
                      message: 'Only UK postcodes allowed.'
                    }

  after_validation do
    self.value = value.to_s.strip.upcase.gsub(' ', '')
  end
end
