require_relative 'base_decorator'

# CapitalizeDecorator
class CapitalizeDecorator < BaseDecorator
  def correct_name
    super().to_s.capitalize
  end
end
