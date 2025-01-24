require 'fox16'
require_relative '../Database/db_connection'
require_relative '../Adapter/student_list_db_adapter'
require_relative '../Adapter/list_adapter'
include Fox
class StudentApplication < FXMainWindow
  def initialize(app, db_name)
    super(app, "Students list", width: 1400, height: 900)

    @controller = StudentListController.new(self, db_name)
    @cur_page = 1
    @list_size = 25

    table_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    table1 = FXTabItem.new(table_book, "Students list")

    table1_frame = FXVerticalFrame.new(table_book, LAYOUT_FILL)

    filter_frame = FXVerticalFrame.new(table1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    #Filter FIELDS
    name_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(name_frame, "initials:")
    @name_field = FXTextField.new(name_frame, 25)

    git_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(git_frame, "Has git?")
    @git_choice = FXComboBox.new(git_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @git_choice.appendItem("Yes")
    @git_choice.appendItem("No")
    @git_choice.appendItem("Not matter")
    @git_choice.numVisible = 3
    FXLabel.new(git_frame, "Find by GitHub:")
    @git_search_field = FXTextField.new(git_frame, 25)
    @git_search_field.enabled = true

    @git_choice.connect(SEL_COMMAND) do
      case @git_choice.currentItem
      when 0
        @git_search_field.enabled = true
      else
        @git_search_field.enabled = false
        @git_search_field.text = ""
      end
    end

    email_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(email_frame, "Has email?")
    @email_choice = FXComboBox.new(email_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @email_choice.appendItem("Yes")
    @email_choice.appendItem("No")
    @email_choice.appendItem("Not matter")
    @email_choice.numVisible = 3
    FXLabel.new(email_frame, "Find by email:")
    @email_search_field = FXTextField.new(email_frame, 25)
    @email_search_field.enabled = true
    @email_choice.connect(SEL_COMMAND) do
      case @email_choice.currentItem
      when 0
        @email_search_field.enabled = true
      else
        @email_search_field.enabled = false
        @email_search_field.text = ""
      end
    end

    phone_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(phone_frame, "Has phone?")
    @phone_choice = FXComboBox.new(phone_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @phone_choice.appendItem("Yes")
    @phone_choice.appendItem("No")
    @phone_choice.appendItem("Not matter")
    @phone_choice.numVisible = 3
    FXLabel.new(phone_frame, "Find by phone:")
    @phone_search_field = FXTextField.new(phone_frame, 25)
    @phone_search_field.enabled = true
    @phone_choice.connect(SEL_COMMAND) do
      case @phone_choice.currentItem
      when 0
        @phone_search_field.enabled = true
      else
        @phone_search_field.enabled = false
        @phone_search_field.text = ""
      end
    end

    telegram_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(telegram_frame, "Has telegram?")
    @telegram_choice = FXComboBox.new(telegram_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @telegram_choice.appendItem("Yes")
    @telegram_choice.appendItem("No")
    @telegram_choice.appendItem("Not Matter")
    @telegram_choice.numVisible = 3
    FXLabel.new(telegram_frame, "Find by Telegram:")
    @telegram_search_field = FXTextField.new(telegram_frame, 25)
    @telegram_search_field.enabled = true
    @telegram_choice.connect(SEL_COMMAND) do
      @telegram_search_field.enabled = @telegram_choice.currentItem == 0
      @telegram_search_field.text = "" unless @telegram_search_field.enabled
    end

    table_frame = FXHorizontalFrame.new(table1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL | TABLE_READONLY | TABLE_NO_COLSELECT)
    configure_table
    #pages
    pagination_frame = FXHorizontalFrame.new(table1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    prev_button = FXButton.new(pagination_frame, "Previous")
    @page_label = FXLabel.new(pagination_frame, "Page: 1/1", nil, JUSTIFY_CENTER_X)
    next_button = FXButton.new(pagination_frame, "Next")
    prev_button.connect(SEL_COMMAND) { change_page(-1) }
    next_button.connect(SEL_COMMAND) { change_page(1) }

    control_frame = FXHorizontalFrame.new(table1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_but = FXButton.new(control_frame, "Add")
    edit_but = FXButton.new(control_frame, "Edit")
    delete_but = FXButton.new(control_frame, "Delete")
    update_but = FXButton.new(control_frame, "Update")

    edit_but.enabled = false
    delete_but.enabled = false

    @table.connect(SEL_SELECTED) do
      selected_rows = (@table.selStartRow..@table.selEndRow).to_a
      selected_rows_count = selected_rows.count {|row| @table.rowSelected?(row)}

      if selected_rows_count == 0
        edit_but.enabled = false
        delete_but.enabled = false
      elsif selected_rows_count == 1
        edit_but.enabled = true
        delete_but.enabled = true
      else
        edit_but.enabled = false
        delete_but.enabled = true
      end
    end

    @table.connect(SEL_DESELECTED) do
      edit_but.enabled = false
      delete_but.enabled = false
    end

    table2 = FXTabItem.new(table_book, "2")
    FXVerticalFrame.new(table_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "2", nil, LAYOUT_CENTER_X)
    end
    table3 = FXTabItem.new(table_book, "3")
    FXVerticalFrame.new(table_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "3", nil, LAYOUT_CENTER_X)
    end
    quit_button = FXButton.new(self, "Exit", nil, nil, 0, FRAME_RAISED | LAYOUT_FILL_X)
    quit_button.connect(SEL_COMMAND) { getApp().exit }
    load_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private

  def load_data
    total_items = @list.get_student_count(@filter)
    total_pages = (total_items.to_f / @list_size).ceil

    update_pagination_label(@cur_page, total_pages)

    data_table = @list.get_k_n_student_short_list(@cur_page, @list_size, @filter)

    @table.setTableSize(data_table.row_count - 1, data_table.col_count)

    column_names = data_table.get_element(0, 0..data_table.col_count - 1)
    column_names.each_with_index do |name, index|
      @table.setColumnText(index, name)
    end

    (1...data_table.row_count).each do |row_index|
      (0...data_table.col_count).each do |col_index|
        @table.setItemText(row_index - 1, col_index, data_table.get_element(row_index, col_index).to_s)
      end
    end
  end

  def update_pagination_label(page, total_pages)
    @page_label.text = "Page: #{page} of #{total_pages}"
  end

  def change_page(page)
    total_items = @list.get_student_count
    total_pages = (total_items.to_f / @list_size).ceil

    new_page = @cur_page + page
    return if new_page < 1 || new_page > total_pages

    @cur_page = new_page
    load_data
  end
end