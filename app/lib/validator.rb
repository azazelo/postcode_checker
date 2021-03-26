# Checks if postcode exists in Storage
#
class Validator
  def check_value(checkable)
    checkable.validators.map do |validator|
      validator.validate(checkable)
    end.all?
  end
end

