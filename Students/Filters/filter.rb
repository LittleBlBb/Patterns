class Filter
  def initialize(filter = nil)
    @filter = filter
  end

  def apply_filter(data)
    if @filter
      @filter.apply_filter(data)
    else
      data
    end
  end
end