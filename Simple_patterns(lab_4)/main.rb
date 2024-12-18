require_relative '../class_student/student'
require_relative '../class_student/StudentShort'
require_relative '../Simple_patterns(lab_4)/Data_list'
require_relative '../Simple_patterns(lab_4)/Data_list_student_short'
require_relative '../Simple_patterns(lab_4)/Student_list/student_list_json'
require_relative '../Simple_patterns(lab_4)/Student_list/student_list_yaml'
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

  data_list = Data_list_student_short.new([st1, st2])
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

  list_json = Student_list_JSON.new('C:\Users\Kertis\Desktop\Ruby\Simple_patterns(lab_4)\Student_list\students.json')
  puts list_json.sort_by_initials
  puts list_json.get_student_count
  puts list_json.get_k_n_student_short_list(0, 2)

  list_yaml = Student_list_YAML.new('C:\Users\Kertis\Desktop\Ruby\Simple_patterns(lab_4)\Student_list\students.yaml')
  puts list_yaml.sort_by_initials
  puts list_yaml.get_student_count
  puts list_yaml.get_k_n_student_short_list(0, 2)

rescue ArgumentError => e
  puts e.message
end
