# frozen_string_literal: true

# Model to keep represent chek object
#
class Check < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  # uk_postcode_checkers defined 
  # in app/models/concerns/u_k_postcode_checkers.rb
  extend UKPostcodeCheckersConf
  acts_as_checkable uk_postcode_checkers_conf
  
end
