# spec/base_decorator_spec.rb
require_relative '../decorators/base_decorator'

class NameableMock < Nameable
  def correct_name
    'mock_name'
  end
end

RSpec.describe BaseDecorator do
  let(:nameable_mock) { NameableMock.new }
  let(:base_decorator) { BaseDecorator.new(nameable_mock) }

  describe '#correct_name' do
    it 'delegates to the wrapped object' do
      expect(base_decorator.correct_name).to eq('mock_name')
    end
  end
end
