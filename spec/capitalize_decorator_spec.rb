# spec/capitalize_decorator_spec.rb
require_relative '../decorators/capitalize_decorator'

class NameableMock < Nameable
  def correct_name
    'mock_name'
  end
end

RSpec.describe CapitalizeDecorator do
  let(:nameable_mock) { NameableMock.new }
  let(:capitalize_decorator) { CapitalizeDecorator.new(nameable_mock) }

  describe '#correct_name' do
    it 'capitalizes the name' do
      expect(capitalize_decorator.correct_name).to eq('Mock_name')
    end
  end
end
