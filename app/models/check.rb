class Check < ApplicationRecord
  attr_reader :checkers
  
  def allowed?
    Checkable.new(value: value)
    .check(
      [
#        storage_checker
        external_api_checker
      ]
    )

#    @check = Check.new(
#      check_params.merge(
#        checkers:
#        [
#          FormatChecker,
#          StorageChecker,
#          PostcodesIOChecker
#        ]
#      )
#    )
  end
  
  private
  
  def storage_checker
    StorageChecker.new(klass: Postcode)
  end

  def external_api_checker
    ExternalApiChecker.new(path: 'http://postcodes.io/postcodes/')
  end

  
  def perform
    checkers.map do |checker|
      checker.check(value)
    end
  end  
end
