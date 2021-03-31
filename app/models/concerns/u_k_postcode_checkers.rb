# frozen_string_literal: true

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module UKPostcodeCheckers
  extend ActiveSupport::Concern

  def uk_postcode_checkers
    {
      validator: validator_conf,
      storage_checker: storage_checker_conf,
      external_api_checker: external_api_checker_conf
    }
  end

  def validator_conf
    {
      format: {
        name: 'UK Postcodes',
        regex: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i
      }
    }
  end

  def storage_checker_conf
    { storage_class: Postcode }
  end

  def external_api_checker_conf
    {
      path: 'http://api.postcodes.io/postcodes/',
      check_method: proc { |result_hash|
        District.pluck(:name).include?(result_hash['result']['admin_district'])
      }
    }
  end
end
