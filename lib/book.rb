require_relative 'rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  # Method for adding rentals
  def add_rental(person, date)
    Rental.new(date, self, person)
  end
end