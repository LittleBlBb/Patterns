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

def prime?(number)
  return false if number <= 1
  (2..Math.sqrt(number)).none? {|i| number % i == 0}
end

#1
def count_after_last_max(array)
	array
		.drop(array.rindex(array.max) + 1)
		.compact
		.size
end

#13
#Метод перемещения элементов до минимального в конец списка с явным вызовом блока
def move_elements(array)
	array
		.min
		.then{|min| array.index(min)}
		.then{|min_index| array[min_index..-1] + array[0..min_index]}
end

#25
def max_element_in_interval(array, start_index, end_index)
	new_array = array[start_index..end_index]
	max = new_array[0]
	new_array.reduce{|max, number| number > max ? number : max }
end

#37
#Методы с неявной передачей блока кода
def find_indices_and_count(array)
	indices = array[1..-1].zip(array).map.with_index(1) do |(current, prev), i|
		if current < prev
			i
		end
	end.compact
  return indices, indices.size
end

#49
def unique_prime_divisors(array)
	array
		.map{|number| (2..number).select {|divisor| number % divisor == 0 && prime?(divisor)}}
		.flatten.uniq
end

def choose_task
	puts "Введите номер задачи:\n" + 
	"1 - Найти количество элементов, расположенных после последнего максимального.\n" +
  "2 - Разместить элементы до минимального в конец массива.\n" +
	"3 - Найти максимальное число в массиве в заданном диапазоне.\n" +
	"4 - Найти индексы элементов, меньших, чем их левые соседи.\n" +
  "5 - Построить список всех положительных простых делителей элементов списка без повторений."
  	task = gets.chomp.to_i

  	case task
    when 1
      array = read_input
      puts count_after_last_max(array)
  	when 2
  		array = read_input
  		puts move_elements(array)
  	when 3
  		array = read_input
  		puts "start index: "
  		start_index = gets.chomp.to_i
  		puts "end index: "
  		end_index = gets.chomp.to_i
  		max = max_element_in_interval(array, start_index, end_index)
  		puts max
  	when 4
  		array = read_input
  		puts find_indices_and_count(array)
    when 5
      array = read_input
      puts unique_prime_divisors(array)
  	else
  		puts "Неверный выбор. Попробуйте снова"
  		choose_task
  	end
end

choose_task