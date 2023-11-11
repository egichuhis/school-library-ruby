#main.rb
require_relative 'app'

def display_options
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
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
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  type = gets.chomp
  print 'Name: '
  name = gets.chomp
  print 'Age: '
  age = gets.chomp.to_i

  if type == '1'
    if age < 18
      print 'Has parent permission? [Y/N]: '
      parent_permission = gets.chomp.downcase
      if parent_permission == 'y'
        app.create_person(type, name, age, parent_permission)
      else
        puts 'You are not allowed to continue.'
        exit
      end
    else
      app.create_person(type, name, age, true)
    end
  else
    print 'Specialization: '
    specialization = gets.chomp
    app.create_person(type, name, age, true, specialization)
  end
end

def create_book(app)
  print 'Book Title: '
  title = gets.chomp
  print 'Book Author: '
  author = gets.chomp
  app.create_book(title, author)
end

def create_rental(app)
  book_index = app.select_book
  person_index = app.select_person
  print 'Enter rental date: '
  date = gets.chomp
  app.create_rental(person_index, book_index, date)
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
