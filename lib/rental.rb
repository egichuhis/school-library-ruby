# rental.rb
require 'json'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def id
    object_id
  end

  def to_json(options = {})
    {
      date: @date,
      book_id: @book.id,
      person_id: @person.id
    }.to_json(options)
  end

  def self.from_json(json, books)
    data = JSON.parse(json)
    date = data['date']
    book_id = data['book_id']
    book = Book.find_by_id(book_id, books)
    person = Person.from_json(data['person'])
    Rental.new(date, book, person)
  rescue StandardError => e
    puts "Error parsing Rental JSON: #{json}"
    raise e
  end

  def to_s
    "Rental(date: #{@date}, book: #{@book}, person: #{@person})"
  end
end
