# spec/trimmer_decorator_spec.rb
require_relative '../decorators/trimmer_decorator'

class NameableMock < Nameable
  def correct_name
    'mock_name'
  end
end

RSpec.describe TrimmerDecorator do
  let(:nameable_mock) { NameableMock.new }
  let(:trimmer_decorator) { TrimmerDecorator.new(nameable_mock) }

  describe '#correct_name' do
    it 'trims the name to 10 characters' do
      expect(trimmer_decorator.correct_name).to eq('mock_name')
    end
  end
end
