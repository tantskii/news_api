require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation check' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :username }
  end

  context 'self.authenticate' do
    user = FactoryGirl.create(:user)

    it 'returns user if password and username are correct' do
      result = User.authenticate(user.username, user.password)
      expect(result).to eq user
    end

    it 'returns nil if password is not correct' do
      result = User.authenticate(user.username, '123')
      expect(result).to eq nil
    end

    it 'returns nil if username is not correct' do
      result = User.authenticate('user_name', user.password)
      expect(result).to eq nil
    end
  end
end
