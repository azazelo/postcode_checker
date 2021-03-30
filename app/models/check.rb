class Check < ApplicationRecord
  include Checkability
  
  attr_accessor :allowed, :messages
  
  validates :value, presence: true, uniqueness: true
  
  after_initialize :setup
  def setup
    self.allowed = nil
    self.messages = []
  end

  def perform
    self.allowed = _check
    self.messages << "Postcode '#{value}' is #{_allowness}. "
  end
  
  def _allowness
    self.allowed ? 'ALLOWED' : 'NOT allowed'
  end
  
  def _check
    Checkability::Checkable.new(self)
    .check(
      proc { |a, b, c| a && ( b || c ) },
      [ 
        Checkability::Validator.new(validator_conf),
        Checkability::StorageChecker.new(storage_conf), 
        Checkability::ExternalApiChecker.new(external_api_conf)
      ]
    )
  end
  
  def storage_conf
    { storage_class: Postcode }
  end
  
  def external_api_conf
    { 
      path: 'http://api.postcodes.io/postcodes/',
      check_method: proc { |result_hash|
        %w(Southwark Lambeth).include?(result_hash['result']['primary_care_trust'])
      }
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
  
end
