# frozen_string_literal: true

# Model to keep allowed postcodes
#
class Postcode < ApplicationRecord
  include PostcodeNormalizer
  before_validation :normalize_postcode
  validates :value, presence: true,
                    #                    uniqueness: { case_sensitive: true },
                    format: {
                      with: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i,
                      message: 'Only UK postcodes allowed.'
                    }
  validates_uniqueness_of :value, case_sensitive: false
end
