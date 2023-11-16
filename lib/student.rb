# student.rb
class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = nil
  end

  def classroom=(classroom)
    return if @classroom == classroom

    @classroom&.students&.delete(self)

    @classroom = classroom

    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def to_json(options = {})
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      classroom: @classroom&.id,
      rentals: @rentals.map(&:id)
    }.to_json(options)
  end

  def self.from_json(json)
    data = JSON.parse(json)
    student = new(data['age'], data['name'], parent_permission: data['parent_permission'])
    student.instance_variable_set(:@id, data['id'])
    student.instance_variable_set(:@classroom, Classroom.from_json(data['classroom'])) if data['classroom']
    # No need to deserialize rentals here, as it's done in the StoringData class
    student
  end

  def to_s
    "Student(id: #{@id}, name: #{@name}, age: #{@age}, parent_permission: #{@parent_permission}, classroom: #{@classroom}, rentals: #{@rentals})"
  end
end
