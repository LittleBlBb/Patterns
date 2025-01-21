require_relative '../Filters/filtersDecorator'
class EmptyGitFilter < FiltersDecorator
  def apply_filter(data)
    super(data).select {|student| student.has_github?}
  end
end
