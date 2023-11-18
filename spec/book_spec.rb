# spec/book_spec.rb
require_relative '../lib/book'
require_relative '../lib/person'

RSpec.describe Book do
  let(:book_title) { 'The Great Gatsby' }
  let(:book_author) { 'F. Scott Fitzgerald' }
  let(:book) { Book.new(book_title, book_author) }

  describe '#initialize' do
    it 'creates a new book with a title and author' do
      expect(book.title).to eq(book_title)
      expect(book.author).to eq(book_author)
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    let(:person) { Person.new(25, 'John Doe', parent_permission: true) }
    let(:rental_date) { '2023-11-15' }

    it 'adds a new rental to the book' do
      rental = book.add_rental(person, rental_date)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.person).to eq(person)
      expect(rental.book).to eq(book)
      expect(rental.date).to eq(rental_date)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'converts book to JSON' do
      json_data = book.to_json
      parsed_data = JSON.parse(json_data)
      expect(parsed_data['id']).to eq(book.id)
      expect(parsed_data['title']).to eq(book.title)
      expect(parsed_data['author']).to eq(book.author)
      expect(parsed_data['rentals']).to eq(book.rentals.map(&:id))
    end
  end

  describe '.from_json' do
    it 'creates a book from JSON data' do
      json_data = '{"id": 123, "title": "To Kill a Mockingbird", "author": "Harper Lee", "rentals": [456, 789]}'
      book_from_json = Book.from_json(json_data)

      expect(book_from_json.id).to eq(123)
      expect(book_from_json.title).to eq('To Kill a Mockingbird')
      expect(book_from_json.author).to eq('Harper Lee')
      expect(book_from_json.rentals).to be_empty # Rentals are not deserialized here
    end
  end

  describe '.find_by_id' do
    let(:books) { [book, Book.new('1984', 'George Orwell')] }

    it 'finds a book by ID in a collection' do
      found_book = Book.find_by_id(book.id, books)
      expect(found_book).to eq(book)
    end

    it 'returns nil if book with the ID is not found' do
      found_book = Book.find_by_id(999, books)
      expect(found_book).to be_nil
    end
  end
end
