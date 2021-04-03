# frozen_string_literal: true

# Keep configuration for checkers
#
module UKPostcodeCheckersConf
  extend ActiveSupport::Concern

  def uk_postcode_checkers_conf
    {
      first_handler: 'Validator',
      handler_confs: {
        'Validator' => validator_conf,
        'Storage' => storage_conf,
        'ApiValidator' => api_validator_conf,
        'ApiFinder' => api_finder_conf
      }
    }
  end

  # checkers (names - Important):
  #   validator            -> Validator
  #   storage_checker      -> StorageChecker
  #   external_api_checker -> ExternalApiChecker
  #

  def validator_conf
    { name: :validator,
      next_handler: 'Storage',
      stop_process_on_failure: true,

      format: {
        name: 'UK Postcodes',
        regex: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i
      } }
  end

  def storage_conf
    { name: :storage_checker,
      next_handler: 'ApiValidator',
      stop_process_on_success: true,

      storage_class: Postcode }
  end

  def api_validator_conf
    { next_handler: 'ApiFinder',
      name: :external_api_checker,
      stop_process_on_failure: true,

      path: 'http://api.postcodes.io/postcodes/',
      http_verb: :get,
      path_suffix: '/validate',
      check_method: proc { |result_hash|
        result_hash['result'] == true
      },
      success_message: 'Postcode IS VALID.',
      failure_message: 'Postcode IS NOT VALID.' }
  end

  def api_finder_conf
    { name: :external_api_checker,
      next_handler: nil,
      stop_process_on_success: true,

      path: 'http://api.postcodes.io/postcodes/',
      check_method: proc { |result_hash|
        District.pluck(:name).include?(result_hash['result']['admin_district'])
      },
      success_message: 'Postcode IS INSIDE allowed areas.',
      failure_message: 'Postcode IS NOT INSIDE of allowed areas.' }
  end
end
