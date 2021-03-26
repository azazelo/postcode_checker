# Checks if postcode exists in Storage
#
class StorageChecker
  attr_reader :klass

  def initialize(args)
    @klass = args[:klass]
  end

  def check_value(value)
    klass.find_by_value(value).present?
  end
end
