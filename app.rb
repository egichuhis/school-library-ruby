# app.rb
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
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'All People:'
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, " \
             "Age: #{person.age}, Specialization: #{person.specialization}"
      else
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person(type, name, age, parent_permission: false, specialization: nil)
    if type == '1'
      if age < 18
        print 'Does the student have parent permission? (yes/no): '
        parent_permission = gets.chomp.downcase == 'yes'
      end
      @people << Student.new(age, name, parent_permission: parent_permission)
      puts "Name: #{name}"
      puts "Age: #{age}"
      puts 'Student created successfully.'
    elsif type == '2'
      if age >= 18
        print 'Enter teacher specialization: '
        specialization = gets.chomp
      else
        puts 'Teachers must be 18 or older.'
        return
      end
      @people << Teacher.new(age, name, parent_permission: true, specialization: specialization)
      puts "Name: #{name}"
      puts "Age: #{age}"
      puts "Specialization: #{specialization}"
      puts 'Teacher created successfully.'
    else
      puts "Invalid person type. Please choose '1' for Student or '2' for Teacher."
    end
  end

  def create_book
    title = get_user_input('Enter book title: ').chomp
    author = get_user_input('Enter book author: ').chomp
    create_book_with_params(title, author)
  end

  def create_book_with_params(title, author)
    @books << Book.new(title, author)
    puts "Book created successfully. Title: #{title}, Author: #{author}"
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
      puts "#{index + 1}) Title: #{book.title}, Author: #{book.author}"
    end
    print 'Enter the number of the selected book: '
    selected_index = gets.chomp.to_i - 1
    selected_book = @books[selected_index]

    [selected_index, selected_book.id]
  end

  def select_person
    puts 'Select a person from the following list by number (not ID):'
    @people.each_with_index do |person, index|
      puts "#{index + 1}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    print 'Enter the number of the selected person: '
    person_index = gets.chomp.to_i - 1
    selected_person = @people[person_index]

    [person_index, selected_person.id]
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

  def select_person_type
    puts 'Select person type:'
    puts '1) Student'
    puts '2) Teacher'
    print 'Enter the number of the selected person type: '
    gets.chomp
  end

  def handle_invalid_option
    puts 'Invalid option. Please choose a valid option.'
  end

  def handle_option(choice)
    option_actions = {
      1 => -> { list_all_books },
      2 => -> { list_all_people },
      3 => lambda {
        type = select_person_type.chomp
        name = get_user_input('Name: ').chomp
        age = get_user_input('Age: ').chomp.to_i
        if %w[1 2].include?(type)
          create_person(type, name, age)
        else
          puts 'Invalid person type. Please choose either 1 (Student) or 2 (Teacher).'
        end
      },
      4 => -> { create_book },
      5 => lambda {
        _, person_id = select_person
        _, book_id = select_book
        print 'Enter rental date: '
        date = gets.chomp
        create_rental(person_id, book_id, date)
      },
      6 => lambda {
        print 'Enter person ID: '
        person_id = gets.chomp.to_i
        list_rentals_for_person(person_id)
      },
      7 => -> { exit_app }
    }

    if option_actions.key?(choice)
      option_actions[choice].call
    else
      handle_invalid_option
    end
  end

  def main_loop
    loop do
      display_options
      print 'Choose an option: '
      choice = gets.chomp.to_i
      handle_option(choice)
      puts "\n"
    end
  end

  def exit_app
    puts 'Exiting the app. Goodbye!'
    exit
  end

  private

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def find_book_by_id(id)
    @books.find { |book| book.id == id }
  end

  def get_user_input(prompt)
    print prompt
    gets.chomp
  end
end
