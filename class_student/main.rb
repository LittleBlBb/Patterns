#Подключаем файл с классом Student
require_relative 'student'


# Тестирование

# Создание через объект Student
student = Student.new(
  first_name: "Андрей",
  last_name: "Пшеничнов",
  middle_name: "Александрович",
  id: 1,
  phone: "+79528125252",
  telegram: "@test_telegram",
  email: "apdragon2014@gmail.com",
  github: "https://github.com/LittleBlBb"
)

student2 = StudentShort.new(student)
student2.display_info

# Создание через строку
student3 = StudentShort.new(student.get_info)
student3.display_info

#Тест для read_from_txt
path = "from_txt.txt"
students_from_txt = Student.read_from_txt(path)
students_from_txt.each do |stud|
  stud.display_info
end

#Тест для write_to_txt
path = "C:/Users/Kertis/Desktop/Ruby/class_student/"
file_name = "to_txt.txt"
path += file_name
Student.write_to_txt(path, students_from_txt)

#Тест для ошибок в методе
Student.from_string("    ")