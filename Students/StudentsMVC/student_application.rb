require 'fox16'
include Fox
class StudentApplication < FXMainWindow
  def initialize(app)
    super(app, "Students list", width: 800, height: 600)

    table_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    table1 = FXTabItem.new(table_book, "Student_list_view")

    table1_frame = FXVerticalFrame.new(table_book, LAYOUT_FILL)
    FXLabel.new(table1_frame, "Student_list_view", nil, LAYOUT_CENTER_X)

    table_frame = FXHorizontalFrame.new(table1_frame, LAYOUT_FILL)

    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL)
    @table.setTableSize(0, 4)
    @table.setColumnText(0, "№")
    @table.setColumnText(1, "ФИО")
    @table.setColumnText(2, "Git")
    @table.setColumnText(3, "Контакт")

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
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end