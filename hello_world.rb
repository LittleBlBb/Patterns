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