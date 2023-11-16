# teacher.rb
require_relative 'person'
require 'json'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, name = 'Unknown', parent_permission: true, specialization: nil)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(options = {})
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      specialization: @specialization,
      rentals: @rentals.map { |rental| rental.id }
    }.to_json(options)
  end

  def self.from_json(json)
    data = JSON.parse(json)
    teacher = new(data['age'], data['name'], parent_permission: data['parent_permission'],
                                             specialization: data['specialization'])
    teacher.instance_variable_set(:@id, data['id'])
    # No need to deserialize rentals here, as it's done in the StoringData class
    teacher
  end

  def to_s
    "Teacher(id: #{@id}, name: #{@name}, age: #{@age}, parent_permission: #{@parent_permission}, specialization: #{@specialization}, rentals: #{@rentals})"
  end
end
