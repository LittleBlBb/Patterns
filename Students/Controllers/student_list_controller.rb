class StudentListController
  def initialize(view, db_name)
    @view = view
    db_list = StudentListDBAdapter.new(db_name)
    @list = ListAdapter.new(db_list)
    @data_list_student_short = Data_list_student_short.new([])
    @data_list_student_short.add_observer(@view)
  end

  def refresh_data
    @data_list_student_short.data = @list.get_k_n_student_short_list(@view.cur_page, @view.list_size).data
    @data_list_student_short.selected = @list.get_k_n_student_short_list(@view.cur_page, @view.list_size).selected
    @data_list_student_short.count = @list.get_student_count
    @data_list_student_short.notify
  end

  def update_pagination_label(cur_page, total_pages)
    @view.page_label.text = "Page #{cur_page} of #{total_pages}"
  end

  def change_page(page)
    total_items = @list.get_student_count
    total_pages = (total_items.to_f / @view.list_size).ceil

    new_page = @view.cur_page + page
    return if new_page < 1 || new_page > total_pages

    @view.cur_page = new_page
    refresh_data
  end
end
