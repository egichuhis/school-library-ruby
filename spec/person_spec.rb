# spec/person_spec.rb
require_relative '../lib/person'
require_relative '../lib/book'

RSpec.describe Person do
  let(:person_age) { 25 }
  let(:person_name) { 'John Doe' }
  let(:parent_permission) { true }
  let(:person) { Person.new(person_age, person_name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'creates a new person with age, name, and parent permission' do
      expect(person.age).to eq(person_age)
      expect(person.name).to eq(person_name)
      expect(person.parent_permission).to eq(parent_permission)
      expect(person.rentals).to be_empty
    end
  end

  describe '#correct_name' do
    it 'returns the correct name' do
      expect(person.correct_name).to eq(person_name)
    end
  end

  describe '#can_use_services?' do
    context 'when person is of age' do
      let(:person_age) { 30 }

      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is not of age but has parent permission' do
      let(:person_age) { 16 }

      it 'returns true' do
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when person is not of age and does not have parent permission' do
      let(:person_age) { 16 }
      let(:parent_permission) { false }

      it 'returns false' do
        expect(person.can_use_services?).to be_falsey
      end
    end
  end

  describe '#add_rental' do
    let(:book) { Book.new('The Catcher in the Rye', 'J.D. Salinger') }
    let(:rental_date) { '2023-11-15' }

    it 'adds a new rental for the person' do
      rental = person.add_rental(book, rental_date)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.person).to eq(person)
      expect(rental.book).to eq(book)
      expect(rental.date).to eq(rental_date)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'converts person to JSON' do
      json_data = person.to_json
      parsed_data = JSON.parse(json_data)
      expect(parsed_data['id']).to eq(person.id)
      expect(parsed_data['name']).to eq(person.name)
      expect(parsed_data['age']).to eq(person.age)
      expect(parsed_data['parent_permission']).to eq(person.parent_permission)
      expect(parsed_data['rentals']).to eq(person.rentals.map(&:id))
    end
  end

  describe '.from_json' do
    it 'creates a person from JSON data' do
      json_data = '{"id": 123, "name": "Alice", "age": 22, "parent_permission": true, "rentals": [456, 789]}'
      person_from_json = Person.from_json(json_data, [], [])

      expect(person_from_json.id).to eq(123)
      expect(person_from_json.name).to eq('Alice')
      expect(person_from_json.age).to eq(22)
      expect(person_from_json.parent_permission).to be_truthy
      expect(person_from_json.rentals).to be_empty # Rentals are not deserialized here
    end
  end

  # spec/person_spec.rb

  describe '#to_s' do
    it 'returns a string representation of the person' do
      expected_string = "Person(id: #{person.id}, name: #{person.name}, age: #{person.age}, " \
                        "parent_permission: #{person.parent_permission}, rentals: #{person.rentals})"
      expect(person.to_s).to include(expected_string)
    end
  end
end
