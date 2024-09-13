#Метод для поиска минимального элемента в массиве
def minimal_element_of_array(arr)
	#Проверяем массив на наличие элементов внутри
	if(!arr.empty?)
		min = arr[0]
		#Проходимся по массиву, сравниваем с предыдущим минимальным, выводим
		for element in arr
			if element < min 
				min = element
			end
		end
		return min
	else 
		return "Массив пуст"
	end
end

#Метод для поиска первого положительного элемента в массиве
def first_positive_element(arr)
	#Проверяем массив на наличие элементов внутри
	if(!arr.empty?)
		#Проходимся по массиву, выводим индекс
		for i in 0...arr.length
			if(arr[i] > 0)
				return i
			end
		end
	else
		return "Массив пуст"
	end
end

#Создаем массив чисел, для работы с методами
test_array = [-4,-3,-2,-1,0,1,2,3,4,5]

min = minimal_element_of_array(test_array)
puts("min: #{min}")

first_pos = first_positive_element(test_array)
puts("first_pos: #{first_pos}")
