# frozen_string_literal: true

# Keep configuration for checkers
#
module PostcodeNormalizer
  extend ActiveSupport::Concern

  def normalize_postcode
    self.value = value.to_s.strip.upcase.delete(' ')
  end
end
