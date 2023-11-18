# spec/rental_spec.rb
require_relative '../lib/rental'
require_relative '../lib/book'
require_relative '../lib/person'

RSpec.describe Rental do
  let(:book_title) { 'The Great Gatsby' }
  let(:author) { 'F. Scott Fitzgerald' }
  let(:person_name) { 'Jay Gatsby' }
  let(:rental_date) { '2023-11-15' }

  let(:book) { Book.new(book_title, author) }
  let(:person) { Person.new(30, person_name, parent_permission: true) }
  let(:rental) { Rental.new(rental_date, book, person) }

  describe '#initialize' do
    it 'creates a new rental with date, associated book, and person' do
      expect(rental.date).to eq(rental_date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end

    it 'adds the rental to the book and person' do
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'converts rental to JSON' do
      json_data = rental.to_json
      parsed_data = JSON.parse(json_data)
      expect(parsed_data['date']).to eq(rental_date)
      expect(parsed_data['book_id']).to eq(book.id)
      expect(parsed_data['person_id']).to eq(person.id)
    end
  end

  describe '.find_by_id' do
    it 'finds a rental by ID' do
      found_rental = Rental.find_by_id(rental.id, [book], [person])
      expect(found_rental).to eq(rental)
    end

    it 'returns nil if rental is not found' do
      found_rental = Rental.find_by_id('nonexistent_id', [book], [person])
      expect(found_rental).to be_nil
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the rental' do
      expected_string = "Rental(date: #{rental.date}, book: #{rental.book}, person: #{rental.person})"
      expect(rental.to_s).to eq(expected_string)
    end
  end
end