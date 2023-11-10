# Interface
class Nameable
  def correct_name
    raise NotImplementedError, 'This method must be implemented in the child class.'
  end
end
