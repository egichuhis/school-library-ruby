# Interface
class Nameable
  def correct_name
    raise NotImplementedError, 'This method must be implemented in the child class.'
  end
end

# Person class inheriting from Nameable
class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end

# Base Decorator
class BaseDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

# CapitalizeDecorator
class CapitalizeDecorator < BaseDecorator
  def correct_name
    super().capitalize
  end
end

# TrimmerDecorator
class TrimmerDecorator < BaseDecorator
  def correct_name
    super()[0..9]
  end
end
