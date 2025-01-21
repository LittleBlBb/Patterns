require_relative '../Filters/FiltersDecorator'
class FindByTelegramFilter < FiltersDecorator
  def initialize(filter, telegram)
    super(filter)
    @telegram = telegram
  end

  def apply_filter(filter_data)
    super(filter_data).select { |student| student.telegram = @telegram}
  end
end
