#app.rb
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
    puts "-----------------------------------"
    puts "** Welcome to School Library App **"
    puts "-----------------------------------"
  end

  def list_all_books
    puts 'All Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'All People:'
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}, Specialization: #{person.specialization}"
      else
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person(type, name, age, parent_permission = false, specialization = nil)
  if type == '1'
    @people << Student.new(age, name, parent_permission: parent_permission)
    puts "Name #{name}"
    puts "Age #{age}"
    puts "Student created successfully."
  elsif type == '2'
    @people << Teacher.new(age, name, specialization)
    puts "Name #{name}"
    puts "Age #{age}"
    puts "Specialization #{specialization}"
    puts "Teacher created successfully."
  else
    puts "Invalid person type. Please choose '1' for Student or '2' for Teacher."
  end
end

  def create_book(title, author)
    @books << Book.new(title, author)
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "Book created successfully."
  end

  def create_rental(person_id, book_id, date)
    person = find_person_by_id(person_id)
    book = find_book_by_id(book_id)

    if person && book
      @rentals << Rental.new(date, book, person)
      puts "Rental created successfully for #{person.name} - #{book.title}."
    else
      puts 'Person or book not found.'
    end
  end

  def select_book
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    print 'Enter the number of the selected book: '
    gets.chomp.to_i
  end

  def select_person
    puts 'Select a person from the following list by number (not ID):'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    print 'Enter the number of the selected person: '
    gets.chomp.to_i
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
