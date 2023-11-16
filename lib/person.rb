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
      rentals: @rentals.map(&:id)
    }.to_json(options)
  end

  def self.from_json(json, books, people)
    data = JSON.parse(json)
    # Extract relevant data from JSON
    id = data['id']
    name = data['name']
    age = data['age']
    parent_permission = data['parent_permission']

    # Create a new Person instance
    person = Person.new(age, name, parent_permission: parent_permission)
    person.instance_variable_set(:@id, id) # Set the ID manually

    # If there are rentals in the data, add them to the person's rentals array
    data['rentals']&.each do |rental_id|
      rental = Rental.find_by_id(rental_id, books, people)
      person.rentals << rental if rental
    end

    person
  rescue StandardError => e
    puts "Error parsing Person JSON: #{json}"
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
