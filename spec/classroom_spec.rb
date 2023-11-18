# spec/classroom_spec.rb
require_relative '../lib/classroom'
require_relative '../lib/student'

RSpec.describe Classroom do
  let(:classroom_label) { 'Math' }
  let(:classroom) { Classroom.new(classroom_label) }

  describe '#initialize' do
    it 'creates a new classroom with a label' do
      expect(classroom.label).to eq(classroom_label)
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    let(:student) { Student.new(16, 'Alice', parent_permission: true) }

    it 'adds a student to the classroom and sets the classroom for the student' do
      classroom.add_student(student)
      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
