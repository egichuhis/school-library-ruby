# savedata.rb
require 'json'

class StoringData
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def load_data
    load_people
    load_books
    load_rentals
  end

  def save_data
    save_people
    save_books
    save_rentals
  end

  private

  def load_people
    people_data = JSON.parse(File.read('people.json'))
    @app.people = people_data['people'].map { |person_data| Person.from_json(person_data, @app.books, @app.people) }
  end

  def load_books
    books_data = JSON.parse(File.read('books.json'))
    @app.books = books_data['books'].map { |book_data| Book.from_json(book_data) }
  end

  def load_rentals
    rentals_json_content = File.readable?('rentals.json') ? File.read('rentals.json') : ''
    rentals_data = parse_rentals_json(rentals_json_content)

    @app.rentals = rentals_data['rentals']&.map do |rental_data|
      Rental.from_json(rental_data, @app.books, @app.people)
    end || []

    @app.rentals.each do |rental|
      book = Book.find_by_id(rental.book.id, @app.books)
      book.rentals << rental
    end
  end

  def parse_rentals_json(json_content)
    return {} if json_content.empty?

    JSON.parse(json_content)
  rescue JSON::ParserError
    puts "Error parsing rentals JSON: #{json_content}"
    {}
  end

  def save_people
    existing_people_data = File.exist?('people.json') ? JSON.parse(File.read('people.json'))['people'] : []

    # Identify and update existing entries
    existing_people_data.map! do |existing_person_data|
      existing_person = Person.from_json(existing_person_data, @app.books, @app.people)
      updated_person = @app.people.find { |p| p.id == existing_person.id }

      if updated_person
        updated_person.to_json
      else
        existing_person_data
      end
    end

    # Add new entries
    new_people_data = @app.people.reject { |p| existing_people_data.include?(p.to_json) }.map(&:to_json)

    combined_people_data = (existing_people_data + new_people_data).uniq
    File.write('people.json', JSON.pretty_generate(people: combined_people_data))
  end

  def save_books
    existing_books_data = File.exist?('books.json') ? JSON.parse(File.read('books.json'))['books'] : []

    # Identify and update existing entries
    existing_books_data.map! do |existing_book_data|
      existing_book = Book.from_json(existing_book_data)
      updated_book = @app.books.find { |b| b.id == existing_book.id }

      if updated_book
        updated_book.to_json
      else
        existing_book_data
      end
    end

    # Add new entries
    new_books_data = @app.books.reject { |b| existing_books_data.include?(b.to_json) }.map(&:to_json)

    combined_books_data = (existing_books_data + new_books_data).uniq
    File.write('books.json', JSON.pretty_generate(books: combined_books_data))
  end

  def save_rentals
    existing_rentals_data = File.exist?('rentals.json') ? JSON.parse(File.read('rentals.json'))['rentals'] : []
    new_rentals_data = @app.rentals.map(&:to_json) # Change here

    combined_rentals_data = (existing_rentals_data + new_rentals_data).uniq
    File.write('rentals.json', JSON.pretty_generate(rentals: combined_rentals_data))
  end
end
