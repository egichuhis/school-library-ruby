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
    people_data = {
      people: @app.people.map(&:to_json)
    }

    books_data = {
      books: @app.books.map(&:to_json)
    }

    rentals_data = {
      rentals: @app.rentals.map(&:to_json)
    }

    File.write('people.json', JSON.pretty_generate(people_data))
    File.write('books.json', JSON.pretty_generate(books_data))
    File.write('rentals.json', JSON.pretty_generate(rentals_data))
  end
end
