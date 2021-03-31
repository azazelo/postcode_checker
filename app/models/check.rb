# frozen_string_literal: true

# Model to keep represent chek object
#
class Check < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  extend UKPostcodeCheckers

  # strategy (Strategy):
  #    a proc with logical sentence for how resullts of checks should be treated
  #
  # checkers (names - Important):
  #   validator            -> Validator
  #   storage_checker      -> StorageChecker
  #   external_api_checker -> ExternalApiChecker
  #
  acts_as_checkable strategy: proc { |a, b, c| a && (b || c) },
                    checkers: uk_postcode_checkers
  # uk_postcode_checkers defined
  # in app/models/concerns/u_k_postcode_checkers.rb
end
