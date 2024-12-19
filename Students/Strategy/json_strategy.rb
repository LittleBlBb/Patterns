require 'json'
require_relative 'strategy'
class JSON_strategy < Strategy
  def read(file_path)
    if File.exist?(file_path)
      content = File.read(file_path)
      JSON.parse(content, symbolize_names: true)
    else
      return []
    end
  end

  def write(file_path, content)
    serialized_content = content.map do |student|
      {
        id: student[:id],
        last_name: student[:last_name],
        first_name: student[:first_name],
        middle_name: student[:middle_name],
        phone: student[:phone],
        email: student[:email],
        telegram: student[:telegram],
        birthdate: student[:birthdate],
        github: student[:github]
      }
    end
    File.open(file_path, 'w') { |file| file.write(JSON.pretty_generate(serialized_content)) }
  end
end