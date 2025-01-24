# Подключаем файл с классами
require_relative '../Students/Data_list/Data_list_student_short'
require_relative 'Strategy/json_strategy'
require_relative 'Strategy/yaml_strategy'
require_relative 'student_list'
require_relative 'Student'
require_relative 'StudentShort'
require_relative '../Students/Adapter/student_list_adapter'
require_relative '../Students/Filters/filter'
require_relative '../Students/Filters/empty_git_filter'
# require_relative '../Students/Database/db_connection'
# require_relative './students_list_DB'
require_relative './Views/student_application'
require 'fox16'
include Fox
# #Перенес методы, мол че их пихать в классы, если они есть в рельсах
# def read_from_txt(path)
#   begin
#     raise "Файл не найден или некорректный путь: #{path}" unless File.exist?(path)
#     students = []
#     File.readlines(path).each do |line|
#       next if line.strip.empty?
#       students << Student.from_string(line.strip)
#     end
#     students
#   rescue => e
#     puts "Ошибка: #{e.message}"
#   end
# end
#
# def write_to_txt(path, students)
#   begin
#     File.open(path, 'w') do |file|
#       students.each do |student|
#         file.puts student.to_s
#       end
#     end
#   rescue => e
#     puts "Ошибка записи в файл: #{e.message}"
#   end
# end

# Тестирование

# Создание через объект Student

# hashST = {
#   first_name: "Андрей",
#   last_name: "Пшеничнов",
#   middle_name: "Александрович",
#   id: 1,
#   phone: "+79528125252",
#   telegram: "@test_telegram",
#   email: "apdragon2014@gmail.com",
#   github: "https://github.com/LittleBlBb",
#   birthdate: "May-12-2004"
# }
#
# hash_st = Student.from_hash(hashST)
# puts hash_st

# student1 = Student.new(
#   first_name: "Андрей",
#   last_name: "Пшеничнов",
#   middle_name: "Александрович",
#   id: 1,
#   phone: "+79528125252",
#   telegram: "@test_telegram",
#   email: "apdragon2014@gmail.com",
#   github: "https://github.com/LittleBlBb",
#   birthdate: "May-12-2004"
# )
studentup2 = Student.new(
  first_name: "Test",
  last_name: "Testov",
  middle_name: "Testovich",
  id: 2,
  phone: "+12345178990",
  telegram: "@testttt1",
  email: "test1@gmail.com",
  github: "https://github.com/Test1",
  birthdate: "November 14 2004"
)
# student2 = Student.new(
#   first_name: "Александр",
#   last_name: "Кокосов",
#   middle_name: "Дмитриевич",
#   id: 2,
#   phone: "+78005553535",
#   telegram: "@ALEX_telegram",
#   email: "Example@gmail.com",
#   github: "https://github.com/EXAMPLE",
#   birthdate: "September 16 2004"
# )
# student3 = Student.new(
#   first_name: "Дмитрий",
#   last_name: "Гатилов",
#   middle_name: "Романович",
#   id: 3,
#   phone: "+75555555555",
#   telegram: "@DimasArbusiOpt",
#   email: "DimasArbusiOpt@gmail.com",
#   github: "https://github.com/DimasArbusiOpt",
#   birthdate: "May 22 2005"
# )
#
# puts student.contact
# # puts "Вывод студента 1: \n#{student}"
#
# # # Создание через объект Student (для класса StudentShort)
# # student2 = StudentShort.new(student)
# # puts "Вывод студента 2: \n#{student2}"
#
# # # Создание через строку (с ID и информацией)
# # student_info = student.get_info  # Получаем строку с get_info
# # student3 = StudentShort.from_string(student_info, id: student.id)  # Передаем строку и ID
# # puts "Вывод студента 3: \n#{student3}"
#
# # # Тест для read_from_txt
# # puts "Вывод студентов из файла:\n"
# # path = "from_txt.txt"  # Указываем путь к файлу
# # students_from_txt = read_from_txt(path)
# # students_from_txt.each do |stud|
# #   puts stud
# # end
#
# # puts student.has_github?
# # puts student.get_git_and_contact
#
# # puts student2.has_github?
# # puts student2.has_contact?
# # puts student2.get_git_and_contact

# # Тест для write_to_txt
# write_path = "to_txt.txt"  # Путь для записи в файл
# write_to_txt(write_path, students_from_txt)
#
# # Тест для ошибок в методе
# begin
#   Student.from_string("    ")  # Пустая строка, вызовет ошибку
# rescue => e
#   puts "Ошибка: #{e.message}"
# end
# student_list_json = Student_List.new('C:\Users\Kurdicks\Desktop\Ruby\Students\students.json', JSON_strategy.new)
# student_list_yaml = Student_List.new('C:\Users\Kurdicks\Desktop\Ruby\Students\students.yaml', YAML_strategy.new)
# puts "Sorted JSON Students: #{student_list_json.sort_by_initials}"
# puts "Sorted YAML Students: #{student_list_yaml.sort_by_initials}"
# student_list_json.write
# student_list_yaml.write
# ===================DataBase============
# puts "подключение"
# db = DB_Connection.instance('students.db')
# db2 = DB_Connection.instance('students.db')

# puts db == db2 ? "Singleton works correctly" : "Singleton doesnt work correctly"

# rows = db.execute("SELECT * FROM student;")
# rows.each do |row|
#   puts row.inspect
# end

# SlDB = StudentListDBAdapter.new(db)

# # SlDB.update_student_by_id(3, studentup2)
# SlDB.get_by_id(3)
# puts SlDB.get_k_n_student_short_list(1,3)
# SlDB.add_student(studentup2)
# puts SlDB.get_k_n_student_short_list(1,4)
# puts SlDB.get_student_count
# SlDB.delete_student_by_id(3)
# puts SlDB.get_k_n_student_short_list(1,15)


# db.close

# begin
#   yaml = YAML_strategy.new
#   stLAdapter = StudentListAdapter.new(yaml, "C:/Users/Kurdicks/Desktop/Ruby/Students/students.yaml")
# list_adapter1 = ListAdapter.new(stLAdapter)
student5 = Student.from_hash(
  id: 5,
  last_name: "Пшеничнов",
  first_name: "Андрей",
  middle_name: "Александрович",
  birthdate: "2004-05-12"
)
# list_adapter1.add_student(student5)
# puts "Всего студентов в файле: #{list_adapter1.get_student_count}"
#   puts list_adapter1
#   puts list_adapter1.get_k_n_student_short_list(1,25)
# #
# student = list_adapter1.get_by_id(1)
# puts "Найден студент: #{student}"
# #
# base=Filter.new
# filter=EmptyGitFilter.new(base)
# #   puts "here"
# # shrt_list = list_adapter1.get_k_n_student_short_list(1, 40, filter)
# # puts shrt_list
# #   puts "upper"
# # puts list_adapter1.get_student_count(filter)
# #
# #   puts "list1 done"
#
#
# con = DB_Connection.instance('students.db')
#
# list_adapter2 = ListAdapter.new(StudentListDBAdapter.new(con))
#
# puts "Всего студентов в БД: #{list_adapter2.get_student_count}"
# student = list_adapter2.get_by_id(2)
# puts "Найден студент: #{student}"
# list_adapter2.add_student(student)
# list_adapter2.add_student(student5)
# list=list_adapter2.get_k_n_student_short_list(2, 10)
#   puts list
# rescue ArgumentError => e
#   puts e.message
# end
#====================MVC======================
begin
  if __FILE__ == $0
    FXApp.new do |app|
      StudentApplication.new(app, 'students.db')
      app.create
      app.run
    end
  end
rescue ArgumentError => e
  puts e.message
end

