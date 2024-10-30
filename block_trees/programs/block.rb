# Чтение данных из файла или с клавиатуры
def read_input
  puts "Введите 'f' для чтения из файла или 'k' для ввода с клавиатуры:"
  input_type = gets.chomp

  case input_type
  when 'f'
    puts "Введите имя файла:"
      filename = gets.chomp
      File.readlines(filename).map(&:to_i)
  when 'k'
    puts "Введите массив целых чисел через пробел:"
    gets.chomp.split.map(&:to_i)
  else
    puts "Неверный выбор. Попробуйте снова."
    read_input
  end
end

#Метод перемещения элементов до минимального в конец списка с явным вызовом блока
def move_elements(array, &block)
  min_index = array.index(array.min)

  new_array = array[min_index..-1] + array[0...min_index]

  block.call(new_array) if block_given?
end

def max_element_in_interval(array, start_index, end_index, &block)
  new_array = array[start_index..end_index]
  max = new_array[0]
  block.call(new_array) if block_given?
  new_array.each {|number| max = number if number > max}  

  max
end

def choose_task
  puts "Введите номер задачи:\n" + 
  "1 - Разместить элементы до минимального в конец массива.\n" +
  "2 - Найти максимальное число в массиве в заданном диапазоне."
    task = gets.chomp.to_i

    case task
    when 1
      array = read_input
      move_elements(array) do |result|
        puts "Result: #{result.inspect}"
      end
    when 2
      array = read_input
      start_index = gets.chomp.to_i
      end_index = gets.chomp.to_i
      max = max_element_in_interval(array, start_index, end_index) do |example|
        puts "Result: #{example}"
      end
      puts max
    else
      puts "Неверный выбор. Попробуйте снова"
      choose_task
    end
end

choose_task