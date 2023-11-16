# book.rb
require 'json'
require_relative 'rental'

class Book
  attr_reader :id
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @id = Random.rand(1..1000)
    @title = title
    @author = author
    @rentals = []
  end

  # Method for adding rentals
  def add_rental(person, date)
    Rental.new(date, self, person)
  end

  def to_json(options = {})
    {
      id: @id,
      title: @title,
      author: @author,
      rentals: @rentals.map(&:id)
    }.to_json(options)
  end

  def self.from_json(json)
    data = JSON.parse(json)
    book = new(data['title'], data['author'])
    book.instance_variable_set(:@id, data['id'])
    # No need to deserialize rentals here, as it's done in the StoringData class
    book
  end

  def self.find_by_id(id, books)
    books.find { |book| book.id == id }
  end
end
