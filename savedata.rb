# savedata.rb
require 'json'

class StoringData
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def load_data
    data = JSON.parse(File.read('data.json'))

    # Assuming people, books, and rentals are serialized JSON strings
    people = data['people'].map { |person_data| Person.from_json(person_data) }
    books = data['books'].map { |book_data| Book.from_json(book_data) }
    rentals = data['rentals'].map { |rental_data| Rental.from_json(rental_data, books) }

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
    data = {
      people: @app.people.map(&:to_json),
      books: @app.books.map(&:to_json),
      rentals: @app.rentals.map(&:to_json)
    }
    File.write('data.json', JSON.pretty_generate(data))
  end
end
