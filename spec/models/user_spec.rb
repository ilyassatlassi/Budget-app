require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      user = User.new(name: 'John Doe', password: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      User.create(name: 'John Doe', email: 'test@example.com', password: 'password')
      user = User.new(name: 'Jane Smith', email: 'test@example.com', password: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'has many transactions' do
      user = User.new(name: 'John Doe', email: 'test@example.com', password: 'password')
      expect(user).to respond_to(:transactions)
    end

    it 'has many categories' do
      user = User.new(name: 'John Doe', email: 'test@example.com', password: 'password')
      expect(user).to respond_to(:categories)
    end
  end
end
