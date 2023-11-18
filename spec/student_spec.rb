# spec/student_spec.rb
require_relative '../lib/student'
require_relative '../lib/classroom'

RSpec.describe Student do
  let(:student_age) { 16 }
  let(:student_name) { 'Alice' }
  let(:parent_permission) { true }
  let(:student) { Student.new(student_age, student_name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'creates a new student with age, name, parent permission, and nil classroom' do
      expect(student.age).to eq(student_age)
      expect(student.name).to eq(student_name)
      expect(student.parent_permission).to eq(parent_permission)
      expect(student.rentals).to be_empty
      expect(student.classroom).to be_nil
    end
  end

  describe '#classroom=' do
    let(:classroom) { Classroom.new('Math') }

    it 'sets the classroom for the student' do
      student.classroom = classroom
      expect(student.classroom).to eq(classroom)
      expect(classroom.students).to include(student)
    end

    it 'removes the student from the previous classroom' do
      old_classroom = Classroom.new('History')
      student.classroom = old_classroom

      new_classroom = Classroom.new('Physics')
      student.classroom = new_classroom

      expect(old_classroom.students).not_to include(student)
      expect(new_classroom.students).to include(student)
    end

    it 'does not add the student to the classroom if already present' do
      student.classroom = classroom
      student.classroom = classroom
      expect(classroom.students.count(student)).to eq(1)
    end
  end

  describe '#play_hooky' do
    it 'returns a string representation of playing hooky' do
      expect(student.play_hooky).to eq('¯\\(ツ)/¯')
    end
  end

  describe '#to_json' do
    it 'converts student to JSON' do
      json_data = student.to_json
      parsed_data = JSON.parse(json_data)
      expect(parsed_data['id']).to eq(student.id)
      expect(parsed_data['name']).to eq(student.name)
      expect(parsed_data['age']).to eq(student.age)
      expect(parsed_data['parent_permission']).to eq(student.parent_permission)
      expect(parsed_data['classroom']).to eq(student.classroom&.id)
      expect(parsed_data['rentals']).to eq(student.rentals.map(&:id))
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the student' do
      expected_string = "Student(id: #{student.id}, name: #{student.name}, age: #{student.age}, " \
                        "parent_permission: #{student.parent_permission}, " \
                        "classroom: #{student.classroom}, rentals: #{student.rentals})"
      expect(student.to_s).to include(expected_string)
    end
  end
end
