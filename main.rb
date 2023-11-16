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

def main
  app = App.new
  app.main_loop
end

# Run the main method if this file is being executed
main if __FILE__ == $PROGRAM_NAME
