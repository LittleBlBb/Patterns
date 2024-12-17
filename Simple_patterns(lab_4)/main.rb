require_relative '../class_student/student'
require_relative '../class_student/StudentShort'
require_relative '../Simple_patterns(lab_4)/Data_list'
require_relative '../Simple_patterns(lab_4)/Data_list_student_short'
begin
  st1 = Student.new(
    id: 1,
    last_name: "Ivanov",
    first_name: "Ivan",
    middle_name: "Ivanovich",
    phone: "+79528125252",
    telegram: "@test_telegram",
    email: "test@gmail.com",
    github: "https://github.com/test",
    birthdate: "November 12 2004"
    )
  st2 = Student.new(
    first_name: "Андрей",
    last_name: "Пшеничнов",
    middle_name: "Александрович",
    id: 2,
    phone: "+79998125252",
    telegram: "@my_telegram",
    email: "apdragon2014@gmail.com",
    github: "https://github.com/LittleBlBb",
    birthdate: "May 12 2004"
  )
  stsh1 = StudentShort.new(st1)
  stsh2 = StudentShort.new(st2)

  data_list = Data_list.new([st1, st2], ["№", "ФИО", "Гит", "Контакты"])
  data_list.select(0)
  puts "selected: #{data_list.get_selected}"
  data_list.select(1)
  puts "selected: #{data_list.get_selected}"

  list_student_short = Data_list_student_short.new([stsh1, stsh2])
  list_student_short.select(0)
  puts "selected: #{list_student_short.get_selected}"
  list_student_short.select(1)
  puts "selected: #{list_student_short.get_selected}"

  puts "Table of selected students:"
  table = list_student_short.get_data
  puts table

rescue ArgumentError => e
  puts e.message
end
