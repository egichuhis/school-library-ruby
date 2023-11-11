# main.rb
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
  type = select_person_type
  name = get_user_input('Name: ')
  age = get_user_input('Age: ').to_i

  if type == '1'
    create_student(app, name, age)
  else
    create_teacher(app, name, age)
  end
end

def select_person_type
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  gets.chomp
end

def get_user_input(prompt)
  print prompt
  gets.chomp
end

def create_student(app, name, age)
  get_parent_permission(age)
  app.create_person('1', name, age)
end

def create_teacher(app, name, age)
  specialization = get_user_input('Specialization: ')
  app.create_person('2', name, age, specialization: specialization)
end

def get_parent_permission(age)
  if age < 18
    print 'Has parent permission? [Y/N]: '
    gets.chomp.downcase == 'y'
  else
    true
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
  _, person_id = app.select_person
  _, book_id = app.select_book
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
