# base_decorator.rb

require_relative 'nameable'

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
    super().to_s.capitalize
  end
end

# TrimmerDecorator
class TrimmerDecorator < BaseDecorator
  def correct_name
    super()[0..9]
  end
end
