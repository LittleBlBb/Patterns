#Подключаем файл с классом Student
require_relative 'class_student'

#Создание нескольких объектов Student
student1 = Student.new(
	first_name: "Андрей",
	last_name: "Пшеничнов",
	middle_name: "Александрович",
	id: 1,
	phone: "+79528125252",
	telegram: "@test_telegram",
	email: "apdragon2014@gmail.com",
	github: "https://github.com/LittleBlBb"
	)
student2 = Student.new(
	first_name: "Виталий",
	last_name: "Дука",
	middle_name: "Андреевич",
	id: 2,
	phone: "+71234******",
	telegram: "@test_telegram2",
	email: "duka@mail.ru",
	github: "https://github.com/sdnezz"
	)
student3 = Student.new(
	first_name: "Андрей",
	last_name: "Дерябин",
	middle_name: "Александрович",
	id: 3
	)
#Вывод информации о студентах
student1.display_info
student2.display_info
student3.display_info

#Пример использования сеттера и геттера
student1.id = 52
puts("Student's ID: #{student1.id}")
student1.display_info

#Попытка задать некорректные значения
# student1.phone = "12345"       -> Ошибка
# student1.email = "wrong.email" -> Ошибка
# student1.telegram = "tg"       -> Ошибка
student1.github = "github.com/LittleBlBb"

#Тест пройденой валидации
student1.validate

#Тест проваленой валидации
student3.validate

#Тест метода set_contacts
student2.set_contacts(
	email: "testemail@example.ru",
	telegram: "@testtelegram",
	phone: "+79912345436"
	)
student2.display_info

# #Тест метода преобразования в строку и конструктора, который парсит данные из строки
#Пример строки
student_string = "ID: 1; Имя: Андрей; Фамилия: Пшеничнов; Отчество: Александрович; Телефон: +79528125252; Телеграм: @test_telegram; Почта: apdragon2014@gmail.com; GitHub: https://github.com/LittleBlBb"

#Создание объекта через строку
student4 = Student.from_string(student_string)

#Выводим информацию о студенте
puts "ZAZA"
student4.display_info