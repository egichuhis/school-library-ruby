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
  end

  def list_all_books
    puts 'All Books:'
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_all_people
    puts 'All People:'
    @people.each do |person|
      puts "#{person.class.name}: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person(type, name, age)
    if type == 'student'
      @people << Student.new(age, name)
      puts "Student #{name} created."
    elsif type == 'teacher'
      @people << Teacher.new(age, name)
      puts "Teacher #{name} created."
    else
      puts "Invalid person type. Please choose 'student' or 'teacher'."
    end
  end

  def create_book(title, author)
    @books << Book.new(title, author)
    puts "Book #{title} by #{author} created."
  end

  def create_rental(person_id, book_id, date)
    person = find_person_by_id(person_id)
    book = find_book_by_id(book_id)

    if person && book
      @rentals << Rental.new(date, book, person)
      puts "Rental created for #{person.name} - #{book.title}."
    else
      puts 'Person or book not found.'
    end
  end

  def list_rentals_for_person(person_id)
    person = find_person_by_id(person_id)

    if person
      puts "Rentals for #{person.name}:"
      rentals = @rentals.select { |rental| rental.person == person }
      rentals.each do |rental|
        puts "#{rental.book.title} (#{rental.date})"
      end
    else
      puts 'Person not found.'
    end
  end

  private

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def find_book_by_id(id)
    @books.find { |book| book.id == id }
  end
end
