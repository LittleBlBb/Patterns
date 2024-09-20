#Подключаем файл с классом Student
require_relative 'class_student'


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
