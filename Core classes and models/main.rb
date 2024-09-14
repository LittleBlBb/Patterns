#Подключаем файл с классом Student
require_relative 'class_student'

#Создание нескольких объектов Student
student1 = Student.new(
	first_name: "Андрей",
	last_name: "Пшеничнов",
	middle_name: "Александрович",
	id: 1,
	phone: "+7952812525",
	telegram: "@test_telegram",
	email: "apdragon2014@gmail.com",
	github: "https://github.com/LittleBlBb"
	)
student2 = Student.new(
	first_name: "Виталий",
	last_name: "Дука",
	middle_name: "Андреевич",
	id: 2,
	phone: "+7123456789",
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