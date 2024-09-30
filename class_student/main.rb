# Подключаем файл с классом Student
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

# Создание через объект Student (для класса StudentShort)
student2 = StudentShort.new(student)
puts "Вывод студента 2: \n#{student2}"

# Создание через строку (с ID и информацией)
student_info = student.get_info  # Получаем строку с get_info
student3 = StudentShort.from_string(student_info, id: student.id)  # Передаем строку и ID
puts "Вывод студента 3: \n#{student3}"

# Тест для read_from_txt
puts "Вывод студентов из файла:\n"
path = "from_txt.txt"  # Указываем путь к файлу
students_from_txt = Student.read_from_txt(path)
students_from_txt.each do |stud|
  puts stud
end

# Тест для write_to_txt
write_path = "C:/Users/Kertis/Desktop/Ruby/class_student/to_txt.txt"  # Путь для записи в файл
Student.write_to_txt(write_path, students_from_txt)

# Тест для ошибок в методе
begin
  Student.from_string("    ")  # Пустая строка, вызовет ошибку
rescue => e
  puts "Ошибка: #{e.message}"
end
