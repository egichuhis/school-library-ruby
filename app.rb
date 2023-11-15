require_relative 'lib/person'
require_relative 'lib/student'
require_relative 'lib/teacher'
require_relative 'lib/book'
require_relative 'lib/rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    puts '-----------------------------------'
    puts '** Welcome to School Library App **'
    puts '-----------------------------------'
  end

  def list_all_books
    puts 'All Books:'
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_all_people
    puts 'All People:'
    @people.each { |person| puts person_info(person) }
  end

  def create_person(type, name, age, parent_permission: false, specialization: nil)
    case type
    when '1'
      create_student(name, age, parent_permission)
    when '2'
      create_teacher(name, age, specialization)
    else
      puts 'Invalid person type. Please choose either 1 (Student) or 2 (Teacher).'
    end
  end

  def create_book
    title = get_user_input('Enter book title: ').chomp
    author = get_user_input('Enter book author: ').chomp
    create_book_with_params(title, author)
  end

  # ... (other methods)

  private

  def create_student(name, age, parent_permission)
    @people << Student.new(age, name, parent_permission: parent_permission)
    puts "Name: #{name}\nAge: #{age}\nStudent created successfully."
  end

  def create_teacher(name, age, specialization)
    return puts 'Teachers must be 18 or older.' if age < 18

    @people << Teacher.new(age, name, parent_permission: true, specialization: specialization)
    puts "Name: #{name}\nAge: #{age}\nSpecialization: #{specialization}\nTeacher created successfully."
  end

  def person_info(person)
    if person.is_a?(Teacher)
      "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}, Specialization: #{person.specialization}"
    else
      "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  # ... (other methods)
end
