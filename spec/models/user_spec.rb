require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'presence validation' do
    let(:user_data) do
      {
        username: 'Daniel',
        password: 'password',
        role: 'user'
      }
    end

    it 'is valid with all the permitted attributes' do
      valid_user = described_class.new(user_data)
      expect(valid_user).to be_valid
    end

    it 'is not valid if any field is missing' do
      fields = [:username, :password, :role]

      fields.each do |field|
        invalid_user = described_class.new(user_data.except(field))
        expect(invalid_user).not_to be_valid
      end
    end
  end
end
