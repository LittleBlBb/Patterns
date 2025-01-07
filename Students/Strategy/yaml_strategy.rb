require 'yaml'
require 'date'
require_relative 'Strategy.rb'

class YAML_strategy < Strategy
  def read(file_path)
    if File.exist?(file_path)
      content = File.read(file_path)
      return [] if content.strip.empty?  # Проверка на пустой файл
      students = YAML.safe_load(content, permitted_classes: [Symbol, Date], symbolize_names: true)

      students.map do |data|
        # Проверяем, является ли значение даты строкой перед преобразованием в объект Date
        if data[:birthdate].is_a?(String)
          data[:birthdate] = Date.parse(data[:birthdate])
        end
        Student.new(**data)
      end
    else
      return []
    end
  end

  def write(file_path, content)
    serialized_content = content.map do |student|
      {
        id: student.id,
        last_name: student.last_name,
        first_name: student.first_name,
        middle_name: student.middle_name,
        phone: student.phone,
        email: student.email,
        telegram: student.telegram,
        birthdate: student.birthdate.to_s, # Преобразуем объект Date обратно в строку
        github: student.github
      }
    end
    File.open(file_path, 'w') { |file| file.write(YAML.dump(serialized_content)) }
  end
end
