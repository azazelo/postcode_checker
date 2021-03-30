# frozen_string_literal: true

class Check < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  def self.validator_conf
    {
      format: {
        name: 'UK Postcodes',
        regex: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i
      }
    }
  end

  def self.storage_checker_conf
    { storage_class: Postcode }
  end

  def self.external_api_checker_conf
    {
      path: 'http://api.postcodes.io/postcodes/',
      check_method: proc { |result_hash|
        %w[Havering Southwark Lambeth].include?(result_hash['result']['primary_care_trust'])
      }
    }
  end

  # checkers:
  #   validator            -> Validator
  #   storage_checker      -> StorageChecker
  #   external_api_checker -> ExternalApiChecker
  # algoritm:
  #    a proc with logical sentence for how resullts of checks should be treated
  acts_as_checkable algoritm: proc { |a, b, c| a && (b || c) },
                    checkers: {
                      validator: validator_conf,
                      storage_checker: storage_checker_conf,
                      external_api_checker: external_api_checker_conf
                    }
end
