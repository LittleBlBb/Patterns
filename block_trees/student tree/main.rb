require_relative 'student'
require_relative 'binary_tree'

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

path = "from_txt.txt"
students_from_txt = read_from_txt(path)

# puts students_from_txt

tree = Binary_Tree.new(students_from_txt)

puts tree