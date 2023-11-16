# person.rb
require_relative '../interfaces/nameable'
require_relative 'rental'
require 'json'

class Person < Nameable
  attr_reader :id, :name, :age, :rentals
  attr_accessor :parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(book, date)
    Rental.new(date, book, self)
  end

  def to_json(options = {})
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals.map { |rental| rental.id }
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
    "Person(id: #{@id}, name: #{@name}, age: #{@age}, parent_permission: #{@parent_permission}, rentals: #{@rentals})"
  end

  private

  def of_age?
    @age >= 18
  end
end
