require 'yaml'
require_relative 'Strategy.rb'
class YAML_strategy < Strategy
  def read(file_path)
    if File.exist?(file_path)
      content = File.read(file_path)
      students = YAML.safe_load(content, permitted_classes: [Symbol], symbolize_names: true)
      students.map {|data| Student.new(**data) }
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
        birthdate: student.birthdate,
        github: student.github
      }
    end
    File.open(file_path, 'w') { |file| file.write(serialized_content.to_yaml) }
  end
end