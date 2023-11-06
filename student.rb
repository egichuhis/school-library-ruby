require "./person.rb"

class Student < Person
  def initialize(age, classroom, name = "Unknown", parent_permission = true)
    super()
    @classroom = classroom
  end

  def play_hooky
    "¯\\(ツ)/¯"
  end
end