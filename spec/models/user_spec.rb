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
      valid_user = User.new(user_data)
      expect(valid_user).to be_valid
    end

    it 'should not be valid if any field is missing' do
      fields = %i[username password role]

      fields.each do |field|
        invalid_user = User.new(user_data.except(field))
        expect(invalid_user).to_not be_valid
      end
    end
  end
end
