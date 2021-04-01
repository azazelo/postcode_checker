# frozen_string_literal: true

# Keep configuration for checkers
#
module UKPostcodeCheckersConf
  extend ActiveSupport::Concern

  def uk_postcode_checkers_conf
    {
      strategy: strategy,
      checker_confs: [
        validator_conf,
        storage_checker_conf,
        external_api_checker_conf_validate,
        external_api_checker_conf_inside_of_district
      ]
    }
  end

  def strategy
    # proc { a && ( b || ( c && d ) ) },
    proc { |validator, storage, ext_api_validate, ext_api_districts|
      validator &&
        (storage ||
          (ext_api_validate && ext_api_districts)
        )
    }
    #    proc { |validator, storage, ext_api_validate, ext_api_districts|
    #      validator &&
    #        ( storage ||
    #          ( ext_api_validate && ext_api_districts )
    #        )
    #      }
  end

  def validator_conf
    {
      name: :validator,
      format: {
        name: 'UK Postcodes',
        regex: /([a-z]{1,2}[0-9]{1,2})([a-z]{1,2})?(\W)?([0-9]{1,2}[a-z]{2})?/i
      },
      stop_process_if_failure: true
    }
  end

  def storage_checker_conf
    { name: :storage_checker,
      storage_class: Postcode,
      stop_process_if_success: true }
  end

  def external_api_checker_conf_validate
    { name: :external_api_checker,
      path: 'http://api.postcodes.io/postcodes/',
      http_verb: :get,
      path_suffix: '/validate',
      check_method: proc { |result_hash|
        result_hash['result'] == true
      },
      stop_process_if_failure: true,
      success_message: 'Postcode IS VALID.',
      failure_message: 'Postcode IS NOT VALID.' }
  end

  def external_api_checker_conf_inside_of_district
    { name: :external_api_checker,
      path: 'http://api.postcodes.io/postcodes/',
      check_method: proc { |result_hash|
        District.pluck(:name).include?(result_hash['result']['admin_district'])
      },
      stop_process_if_success: true,
      success_message: 'Postcode IS INSIDE allowed areas.',
      failure_message: 'Postcode IS NOT INSIDE of allowed areas.' }
  end
end
