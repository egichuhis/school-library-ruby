# spec/teacher_spec.rb
require_relative '../lib/teacher'

RSpec.describe Teacher do
  let(:teacher_age) { 35 }
  let(:teacher_name) { 'Ms. Johnson' }
  let(:specialization) { 'Mathematics' }
  let(:teacher) { Teacher.new(teacher_age, teacher_name, parent_permission: true, specialization: specialization) }

  describe '#initialize' do
    it 'creates a new teacher with age, name, parent permission, and specialization' do
      expect(teacher.age).to eq(teacher_age)
      expect(teacher.name).to eq(teacher_name)
      expect(teacher.parent_permission).to be_truthy
      expect(teacher.specialization).to eq(specialization)
      expect(teacher.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    it 'always returns true for teachers' do
      expect(teacher.can_use_services?).to be_truthy
    end
  end

  describe '#to_json' do
    it 'converts teacher to JSON' do
      json_data = teacher.to_json
      parsed_data = JSON.parse(json_data)
      expect(parsed_data['id']).to eq(teacher.id)
      expect(parsed_data['name']).to eq(teacher.name)
      expect(parsed_data['age']).to eq(teacher.age)
      expect(parsed_data['parent_permission']).to eq(teacher.parent_permission)
      expect(parsed_data['specialization']).to eq(teacher.specialization)
      expect(parsed_data['rentals']).to eq(teacher.rentals.map(&:id))
    end
  end

  describe '.from_json' do
    it 'creates a teacher from JSON data' do
      json_data = '{"id": 789, "name": "Mr. Smith", "age": 40, "parent_permission": true, ' \
                  '"specialization": "Science", "rentals": [303, 404]}'

      teacher_from_json = Teacher.from_json(json_data)

      expect(teacher_from_json.id).to eq(789)
      expect(teacher_from_json.name).to eq('Mr. Smith')
      expect(teacher_from_json.age).to eq(40)
      expect(teacher_from_json.parent_permission).to be_truthy
      expect(teacher_from_json.specialization).to eq('Science')
      expect(teacher_from_json.rentals).to be_empty # Rentals are not deserialized here
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the teacher' do
      expected_string = "Teacher(id: #{teacher.id}, name: #{teacher.name}, age: #{teacher.age}, " \
                        "parent_permission: #{teacher.parent_permission}, specialization: #{teacher.specialization}, " \
                        "rentals: #{teacher.rentals})"
      expect(teacher.to_s).to eq(expected_string)
    end
  end
end