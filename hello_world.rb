#Методы для работы с 4-м заданием
def sum_of_simple_divisors(number)
	list_of_simple_divisors = [] #Создаем массив, куда будем пихаь наши найденные простые делители
	divisor = 2 #Начинаем с двойки, так как 1 не считается простой
	while(divisor * divisor <= number) do 
		if(number % divisor == 0) 
		#Если делится нацело, пушим в массив и делим это число на делитель
			list_of_simple_divisors.push(divisor)
			number /= divisor
		else 
			#Иначе - берем следующий возможный делитель
			divisor += 1
		end
	end
	#если у нас число больше единицы в итоге, то пушим его в массив
	list_of_simple_divisors.push(number) if (number > 1)
	#Выводим сумму
	puts("Сумма простых делителей числа равна #{list_of_simple_divisors.sum}")
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
	puts("Количество нечетных цифр числа, больших 3 равно #{number_of_numbers_found}")
end

#Метод для нахождения произведения таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа 
def product_of_divisors_with_digit_sum_less_than_number(number)
	if(number == 0) 
		puts("Вы ввели число 0, какой результат вы ожидаете?")
		return
	else
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
	
	puts("Произведение делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа #{product}")
	end
end

#Main
#База
puts("Hello, world!")

# Принимаем имя пользователя. Если не передан аргумент, запрашиваем имя у пользователя.
if ARGV.empty?
  puts "Как тебя зовут?"
  name = gets.chomp
else
  name = ARGV[0]
end

printf("Здравствуй, #{name}\n") # Форматированное приветствие

# Очищаем ARGV, чтобы оно не мешало использованию gets
ARGV.clear

# Спросим у пользователя его любимый ЯП
puts('Какой твой любимый язык программирования?')
favorite_lang = gets.chomp.downcase

# Условие на любимый ЯП
case favorite_lang
when 'ruby'
  puts("#{name}-подлиза")
when 'c++'
  puts('Гениалыч?')
when 'c#', 'java'
  puts('Красава')
else
  puts('Неважно, скоро будет Ruby')
end

#Просим пользователя ввести команду Ruby
puts("Введите команду Ruby:")
ruby_command = gets.chomp

#Разбиваем команду на части для дальнейшей проверки, существует ли она в целом.
ruby_command_parts = ruby_command.split(' ')

#Первая часть команды - метод
method_name = ruby_command_parts[0].to_sym

#Проверяем, существует ли метод в классе Kernel(Включает в себя базовые команды типа puts, print)
if (Kernel.respond_to?(method_name))
	puts('Смотри, что ты наделал:')
	eval(ruby_command)
else
	puts("Команда '#{ruby_command}' не найдена")
end

#Просим пользователя выполнить ввести команду ОС
puts("Введите команду ОС:")
os_command = gets.chomp

if system(os_command)
	puts("Выполнено")
else
	puts("Ошибка выполнения")
end

#Просим пользователя ввести число
puts("Введите число")
number = gets.chomp.to_i

#Выполняем метод для подсчета суммы простых делителей заданного числа
sum_of_simple_divisors(number)

#Выполняем метод для подсчета количества нечетных цифр, больших 3 для заданного числа
count_of_odd_numbers_greater_than_three(number)

#Выполняем метод для подсчета произведения таких делителей числа, сумма цифр которых меньше, чем сумма цифр исходного числа
product_of_divisors_with_digit_sum_less_than_number(number)