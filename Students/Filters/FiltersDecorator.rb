require_relative '../Filters/Filter'
class FiltersDecorator < Filter
  def initialize(filter)
    @filter = filter
  end

  def apply_filter(filter_data)
    @filter.apply_filter(filter_data)
  end
end