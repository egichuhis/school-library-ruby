# savedata.rb
require 'json'

class StoringData
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def load_data
    people_data = JSON.parse(File.read('people.json'))
    books_data = JSON.parse(File.read('books.json'))
    rentals_data = JSON.parse(File.read('rentals.json'))

    # Assuming people, books, and rentals are serialized JSON strings
    people = people_data['people'].map { |person_data| Person.from_json(person_data) }
    books = books_data['books'].map { |_books_data| Book.from_json(book_data) }
    rentals = rentals_data['rentals'].map { |rentals_data| Rental.from_json(rentals_data) }

    # Set rentals for each book
    rentals.each do |rental|
      book = Book.find_by_id(rental.book.id, books)
      book.rentals << rental
    end

    @app.people = people
    @app.books = books
    @app.rentals = rentals
  end

  def save_data
    # Save people data
    existing_people_data = File.exist?('people.json') ? JSON.parse(File.read('people.json'))['people'] : []
    new_people_data = @app.people.map(&:to_json)
    combined_people_data = (existing_people_data + new_people_data).uniq
    File.write('people.json', JSON.pretty_generate(people: combined_people_data))

    # Save books data
    existing_books_data = File.exist?('books.json') ? JSON.parse(File.read('books.json'))['books'] : []
    new_books_data = @app.books.map(&:to_json)
    combined_books_data = (existing_books_data + new_books_data).uniq
    File.write('books.json', JSON.pretty_generate(books: combined_books_data))

    # Save rentals data
    existing_rentals_data = File.exist?('rentals.json') ? JSON.parse(File.read('rentals.json'))['rentals'] : []
    new_rentals_data = @app.rentals.map(&:to_json)
    combined_rentals_data = (existing_rentals_data + new_rentals_data).uniq
    File.write('rentals.json', JSON.pretty_generate(rentals: combined_rentals_data))
  end
end
