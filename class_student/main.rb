# Подключаем файл с классами
require_relative 'Student'
require_relative 'StudentShort'
#Перенес методы, мол че их пихать в классы, если они есть в рельсах
def read_from_txt(path)
  begin
    raise "Файл не найден или некорректный путь: #{path}" unless File.exist?(path)
    students = []
    File.readlines(path).each do |line|
      next if line.strip.empty?
      students << Student.from_string(line.strip)
    end
    students
  rescue => e
    puts "Ошибка: #{e.message}"
  end
end

def write_to_txt(path, students)
  begin
    File.open(path, 'w') do |file|
      students.each do |student|
        file.puts student.to_s
      end
    end
  rescue => e
    puts "Ошибка записи в файл: #{e.message}"
  end
end

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
students_from_txt = read_from_txt(path)
students_from_txt.each do |stud|
  puts stud
end

# Тест для write_to_txt
write_path = "to_txt.txt"  # Путь для записи в файл
write_to_txt(write_path, students_from_txt)

# Тест для ошибок в методе
begin
  Student.from_string("    ")  # Пустая строка, вызовет ошибку
rescue => e
  puts "Ошибка: #{e.message}"
end