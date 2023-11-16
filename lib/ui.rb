# ui.rb
module UI
  def display_welcome_message
    puts '-----------------------------------'
    puts '** Welcome to School Library App **'
    puts '-----------------------------------'
  end

  def display_person_info(name, age, specialization = nil)
    puts "Name: #{name}"
    puts "Age: #{age}"
    puts "Specialization: #{specialization}" if specialization
  end

  def display_book_info(title, author)
    puts "Title: #{title}"
    puts "Author: #{author}"
  end

  def display_rental_info(person_name, book_title, date)
    puts "Rental created successfully for #{person_name} - #{book_title}."
    puts "Rental date: #{date}"
  end

  def display_all_books(books)
    puts 'All Books:'
    books.each do |book|
      display_book_info(book.title, book.author)
    end
  end

  def display_all_people(people)
    puts 'All People:'
    people.each do |person|
      if person.is_a?(Teacher)
        display_teacher_info(person)
      else
        display_student_info(person)
      end
    end
  end

  def display_student_info(student)
    puts "[#{student.class.name}] Name: #{student.name}, ID: #{student.id}, " \
         "Age: #{student.age}, Parent Permission: #{student.parent_permission}"
  end

  def display_teacher_info(teacher)
    puts "[#{teacher.class.name}] Name: #{teacher.name}, ID: #{teacher.id}, " \
         "Age: #{teacher.age}, Specialization: #{teacher.specialization}"
  end

  def display_rentals_for_person(person, rentals)
    puts "Rentals for #{person.name}:"
    rentals.each do |rental|
      display_rental_info(person.name, rental.book.title, rental.date)
    end
  end

  def display_options
    puts 'Options:'
    puts '1) List all books'
    puts '2) List all people'
    puts '3) Create a person'
    puts '4) Create a book'
    puts '5) Create a rental'
    puts '6) List rentals for a person'
    puts '7) Exit'
  end

  def get_user_input(prompt)
    print prompt
    gets.chomp
  end

  def get_user_input_number(prompt)
    get_user_input(prompt).to_i
  end
end
