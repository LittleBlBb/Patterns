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
