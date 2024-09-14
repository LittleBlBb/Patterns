#Методы для работы с 4-м заданием
def sum_of_prime_divisors(number)
	list_of_prime_divisors = [] #Создаем массив, куда будем пихаь наши найденные простые делители
	divisor = 2 #Начинаем с двойки, так как 1 не считается простой
	while(divisor * divisor <= number) do 
		if(number % divisor == 0) 
		#Если делится нацело, пушим в массив и делим это число на делитель
			list_of_prime_divisors.push(divisor)
			number /= divisor
		else 
			#Иначе - берем следующий возможный делитель
			divisor += 1
		end
	end
	#если у нас число больше единицы в итоге, то пушим его в массив
	list_of_prime_divisors.push(number) if (number > 1)
	#Выводим сумму
	list_of_prime_divisors.sum
end

#Метод для подсчета нечетных цифр, больших тройки в числе.
def count_of_odd_numbers_greater_than_three(number)
	number_of_numbers_found = 0
	#Пока число существует выполняем алгоритм подсчета
	while(number != 0) do
		last_digit = number % 10 #Выбираем последнюю цифру
		if(last_digit.odd? && last_digit > 3) #Проверяем на нечетность и болььше ли она тройки
			number_of_numbers_found += 1 #Если да, то увеличиваем счетчик
		end
		number /= 10 #Избавляемся от последней цифры числа
	end
	return number_of_numbers_found
end

#Метод для нахождения произведения таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа 
def product_of_divisors_with_digit_sum_less_than_number(number)
	list_of_found_divisors = []
	original_number = number
	original_digit_sum = 0

	#Находим сумму цифр исходного числа
	temp_number = number
	while(temp_number != 0)
		original_digit_sum += temp_number % 10
		temp_number /= 10
	end

	#Проходим по всем делителям числа
	(1..number).each do |i|
		if (number % i == 0)
			divisor_digit_sum = 0
			temp = i

			#Считаем сумму цифр делителя
			while(temp != 0)
				divisor_digit_sum += temp % 10
				temp /= 10
			end

			#Проверяем условие, добавляем делитель в список
			if divisor_digit_sum < original_digit_sum
			    list_of_found_divisors.push(i) 
        	end
		end
	end
	#Если список пуст, произведение равно 1 (ничего не найдено)
	product = list_of_found_divisors.empty? ? 1 : product = list_of_found_divisors.inject(1) { |product, n| product * n }

	return product
end

#Просим пользователя ввести число
puts("Введите число")
number = gets.chomp.to_i

if (number == 0)
	puts("Вы ввели число 0, какой результат вы ожидаете?")
	exit
else
	#Выполняем метод для подсчета суммы простых делителей заданного числа
	puts("Сумма простых делителей числа: #{sum_of_prime_divisors(number)}")

	#Выполняем метод для подсчета количества нечетных цифр, больших 3 для заданного числа
	puts("Количество нечетных чисел больших тройки: #{count_of_odd_numbers_greater_than_three(number)}")

	#Выполняем метод для подсчета произведения таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа
	puts("произведение делителей числа таких что сумма их цифр меньше чем сумма цифр мсходного числа: #{product_of_divisors_with_digit_sum_less_than_number(number)}")
end