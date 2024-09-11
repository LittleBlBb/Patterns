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



# База
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
