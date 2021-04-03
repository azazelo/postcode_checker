# frozen_string_literal: true

# Model to keep represent chek object
#
class Check < ApplicationRecord
  include PostcodeNormalizer
  before_validation :normalize_postcode
  validates :value, presence: true,
                    format: {
                      with: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i,
                      message: 'Only UK postcodes allowed.'
                    }
  # uk_postcode_checkers defined
  # in app/models/concerns/u_k_postcode_checkers.rb
  extend UKPostcodeCheckersConf
  acts_as_checkable uk_postcode_checkers_conf
end
