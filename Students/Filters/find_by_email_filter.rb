require_relative '../Filters/FiltersDecorator'
class FindByEmailFilter < FiltersDecorator
  def initialize(filter, email)
    super(filter)
    @email = email
  end

  def apply_filter(filter_data)
    super(data).select { |student| student.email == @email }
  end
end
