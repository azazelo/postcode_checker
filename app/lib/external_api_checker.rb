# Checks if postcode exists in Storage
#
class ExternalApiChecker
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def check_value(value)
    value.present?
  end
end
