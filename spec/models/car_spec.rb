require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'presence validation' do
    let(:car_data) do
      {
        brand: 'Audi',
        model: '2001',
        monetary_price: 12_345,
        new: false,
        dealerships: %w[one two three]
      }
    end

    it 'is valid with all the permitted attributes' do
      valid_car = described_class.new(car_data)
      expect(valid_car).to be_valid
    end
  end
end
