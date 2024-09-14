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

#Создаем массив чисел, для работы с методами
test_array = [-4,-3,-2,-1,0,1,2,3,4,5]
if(!test_array.empty?)
	test_array.each do |el|
		puts el
	end
else
	puts "massive is empty!"
end

min = minimal_element_of_array(test_array)
puts("min: #{min}")

first_pos = first_positive_element(test_array)
puts("first_pos: #{first_pos}")
