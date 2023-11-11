require_relative 'app'

def display_options
  puts 'Options:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List rentals for a person'
  puts '7. Quit'
end

def handle_option(choice, app)
  option_actions = {
    1 => -> { app.list_all_books },
    2 => -> { app.list_all_people },
    3 => -> { create_person(app) },
    4 => -> { create_book(app) },
    5 => -> { create_rental(app) },
    6 => -> { list_rentals_for_person(app) },
    7 => -> { exit_app }
  }

  option_actions.fetch(choice, method(:handle_invalid_option)).call
end

def handle_invalid_option
  puts 'Invalid option. Please choose a valid option.'
end

def create_person(app)
  print 'Enter person type (student/teacher): '
  type = gets.chomp.downcase
  print 'Enter name: '
  name = gets.chomp
  print 'Enter age: '
  age = gets.chomp.to_i
  app.create_person(type, name, age)
end

def create_book(app)
  print 'Enter book title: '
  title = gets.chomp
  print 'Enter book author: '
  author = gets.chomp
  app.create_book(title, author)
end

def create_rental(app)
  print 'Enter person ID: '
  person_id = gets.chomp.to_i
  print 'Enter book ID: '
  book_id = gets.chomp.to_i
  print 'Enter rental date: '
  date = gets.chomp
  app.create_rental(person_id, book_id, date)
end

def list_rentals_for_person(app)
  print 'Enter person ID: '
  person_id = gets.chomp.to_i
  app.list_rentals_for_person(person_id)
end

def exit_app
  puts 'Exiting the app. Goodbye!'
  exit
end

def main
  app = App.new

  loop do
    display_options
    print 'Choose an option: '
    choice = gets.chomp.to_i
    handle_option(choice, app)
    puts "\n"
  end
end

# Run the main method if this file is being executed
main if __FILE__ == $PROGRAM_NAME
