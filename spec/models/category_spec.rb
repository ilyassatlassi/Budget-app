require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      category = Category.new(icon: 'category-icon')
      expect(category).to_not be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of icon' do
      category = Category.new(name: 'Category Name')
      expect(category).to_not be_valid
      expect(category.errors[:icon]).to include("can't be blank")
    end

    it 'validates length of name' do
      category = Category.new(name: 'a' * 31, icon: 'category-icon')
      expect(category).to_not be_valid
      expect(category.errors[:name]).to include('is too long (maximum is 30 characters)')
    end
  end

  describe 'associations' do
    it 'has many transactions' do
      category = Category.new(name: 'Category Name', icon: 'category-icon')
      expect(category).to respond_to(:transactions)
    end

    it 'belongs to a user' do
      category = Category.new(name: 'Category Name', icon: 'category-icon')
      expect(category).to respond_to(:user)
    end
  end

  describe 'methods' do
    let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }
    let(:category) { Category.create(name: 'Category Name', icon: 'category-icon', user:) }

    describe '#total_amount' do
      context 'when category has transactions' do
        before do
          Transaction.create(name: 'Transaction 1', amount: 100, category:, author: user)
          Transaction.create(name: 'Transaction 2', amount: 200, category:, author: user)
        end

        it 'returns the sum of amounts of all transactions' do
          expect(category.total_amount).to eq(300)
        end
      end

      context 'when category has no transactions' do
        it 'returns 0' do
          expect(category.total_amount).to eq(0)
        end
      end
    end
  end

  # ... other tests ...
end
