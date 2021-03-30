class Postcode < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  before_validation do
    self.value = self.value.strip.upcase.gsub(' ','')
  end
end
