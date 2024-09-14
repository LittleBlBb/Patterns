#Метод для выбора используемого метода
def execute_method(method_number, arr)
	if(arr.empty?)
		puts("Массив пуст!")
		return
	end
	case method_number
	when 1
		puts "Минимальный элемент массива: #{minimal_element_of_array(arr)}"
	when 2
		puts "Индекс первого положительного элемента массива: #{first_positive_element(arr)}"
	else
		puts "Неверный номер метода!"
	end
end

#Метод для поиска минимального элемента в массиве
def minimal_element_of_array(arr)
	min = arr[0]
	#Проходимся по массиву, сравниваем с предыдущим минимальным, выводим
	for element in arr
		if element < min 
			min = element
		end
	end
	return min
end

#Метод для поиска первого положительного элемента в массиве
def first_positive_element(arr)
	#Проходимся по массиву, выводим индекс
	for i in 0...arr.length
		if(arr[i] > 0)
			return i
		end
	end
end

if ARGV.length != 2
	puts("Использование программы: ruby file_name.rb <номер метода> <путь к файлу>")
	exit
end

method_number = ARGV[0].to_i
file_path = ARGV[1]

#Чтение массива из файла
begin
	#Считываем содержимое из файла
	file_content = File.read(file_path)
	arr = file_content.split.map(&:to_i)

	#Выполняем выбранный метод
	execute_method(method_number, arr)
end