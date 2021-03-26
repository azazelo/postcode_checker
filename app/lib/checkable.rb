# Checks if postcode exists in Storage
#
class Checkable
  attr_reader :value

  def initialize(args)
    @value = args[:value]
  end

  def check(checkers)
    checkers.map do |checker|
      checker.check_value(value)
    end.all?
  end
end
