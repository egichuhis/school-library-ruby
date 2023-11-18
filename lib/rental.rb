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

  def self.from_json(json, books, people)
    data = JSON.parse(json)
    date = data['date']
    book_id = data['book_id']
    person_id = data['person_id']

    # Find the book by ID
    book = Book.find_by_id(book_id, books)

    # Find the person by ID
    person = people.find { |p| p.id == person_id }

    Rental.new(date, book, person)
  rescue StandardError => e
    puts "Error parsing Rental JSON: #{json}"
    raise e
  end

  def self.find_by_id(id, books, people)
    books.each do |book|
      rental = book.rentals.find { |r| r.id == id }
      return rental if rental
    end

    people.each do |person|
      rental = person.rentals.find { |r| r.id == id }
      return rental if rental
    end

    nil
  end

  def to_s
    "Rental(date: #{@date}, book: #{@book}, person: #{@person})"
  end
end
