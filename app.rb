# app.rb
require_relative 'lib/person'
require_relative 'lib/student'
require_relative 'lib/teacher'
require_relative 'lib/book'
require_relative 'lib/rental'
require_relative 'lib/ui'
require_relative 'lib/list'
require_relative 'savedata'

class App
  include UI
  include List

  attr_accessor :people, :books, :rentals

  def initialize
    @data_manager = StoringData.new(self)
    @people = []
    @books = []
    @rentals = []
    @data_manager.load_data
    display_welcome_message
  end

  def create_person(type, name, age, specialization: nil)
    if type == '1'
      create_student(name, age)
    elsif type == '2'
      create_teacher(name, age, specialization)
    else
      puts "Invalid person type. Please choose '1' for Student or '2' for Teacher."
    end
  end

  def create_student(name, age)
    parent_permission = age < 18 ? check_parent_permission : false
    @people << Student.new(age, name, parent_permission: parent_permission)
    display_person_info(name, age)
    puts 'Student created successfully.'
  end

  def create_teacher(name, age, specialization)
    if age >= 18
      @people << Teacher.new(age, name, parent_permission: true, specialization: specialization)
      display_person_info(name, age, specialization)
      puts 'Teacher created successfully.'
    else
      puts 'Teachers must be 18 or older.'
    end
  end

  def check_parent_permission
    print 'Does the student have parent permission? (yes/no): '
    gets.chomp.downcase == 'yes'
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
      1 => method(:list_all_books),
      2 => method(:list_all_people),
      3 => method(:handle_create_person),
      4 => method(:create_book),
      5 => method(:handle_create_rental),
      6 => method(:handle_list_rentals_for_person),
      7 => method(:exit_app)
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
    @data_manager.save_data
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

  def handle_create_person
    type = select_person_type.chomp
    name = get_user_input('Name: ').chomp
    age = get_user_input('Age: ').chomp.to_i
    if %w[1 2].include?(type)
      create_person(type, name, age)
    else
      puts 'Invalid person type. Please choose either 1 (Student) or 2 (Teacher).'
    end
  end

  def handle_create_rental
    _, person_id = select_person
    _, book_id = select_book
    print 'Enter rental date: '
    date = gets.chomp
    create_rental(person_id, book_id, date)
  end

  def handle_list_rentals_for_person
    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    list_rentals_for_person(person_id)
  end
end
