require_relative '../Filters/FiltersDecorator'
class FindByPhoneFilter < FiltersDecorator
  def initialize(filter, phone)
    super(filter)
    @phone = phone
  end

  def apply_filter(filter_data)
    super(filter_data).select { |student| student.phone == @phone }
  end
end
