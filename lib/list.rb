# list.rb

module List
  def list_all_books
    puts 'All Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    puts 'All People:'
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, " \
             "Age: #{person.age}, Specialization: #{person.specialization}"
      else
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def list_rentals_for_person(person_id)
    person = find_person_by_id(person_id)

    if person
      puts "Rentals for #{person.name}:"
      rentals = @rentals.select { |rental| rental.person == person }
      rentals.each do |rental|
        puts "#{rental.book.title} (#{rental.date})"
      end
    else
      puts 'Person not found.'
    end
  end
end
