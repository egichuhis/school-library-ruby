# main.rb
require_relative 'lib/person'
require_relative 'lib/classroom'
require_relative 'lib/student'
require_relative 'lib/teacher'
require_relative 'lib/book'
require_relative 'lib/rental'
require_relative 'decorators/base_decorator'
require_relative 'decorators/capitalize_decorator'
require_relative 'decorators/trimmer_decorator'
require_relative 'interfaces/nameable'

# Create a Classroom
# classroom = Classroom.new('Math Class')

# Create a Student and add it to the Classroom
# student = Student.new(18, classroom, 'John Doe')
# puts student.classroom.label # Should print 'Math Class'

# # Create a Book
# book = Book.new('Ruby Programming', 'John Smith')

# # Create a Person
# person = Person.new('Alice', 25)

# # Create a Rental to associate the Person with the Book
# rental = Rental.new('2023-11-10', book, person)

# puts book.rentals.length # Should print 1
# puts person.rentals.length # Should print 1

# book = Book.new('Ruby Programming', 'John Smith')
# person = Person.new('Alice', 25)
# date = '2023-11-10'

# person = Person.new('Alice', 25)
# book = Book.new('Ruby Programming', 'John Smith')
# date = '2023-11-10'

# person.add_rental(book, date)

# book.add_rental(person, date)

# person = Person.new('Maximilianus', 22)
# person.correct_name
# capitalized_person = CapitalizeDecorator.new(person)
# puts capitalized_person.correct_name
# capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
# puts capitalized_trimmed_person.correct_name
