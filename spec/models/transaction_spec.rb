require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      transaction = Transaction.new(amount: 100, category_id: 1, author: User.new)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of amount' do
      transaction = Transaction.new(name: 'Expense', category_id: 1, author: User.new)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:amount]).to include("can't be blank")
    end

    it 'validates presence of category' do
      transaction = Transaction.new(name: 'Expense', amount: 100, author: User.new)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:category]).to include("can't be blank")
    end

    it 'validates that category must belong to a category' do
      transaction = Transaction.new(name: 'Expense', amount: 100, category_id: nil, author: User.new)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:category_id]).to include('must belong to a category')
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      transaction = Transaction.new(name: 'Expense', amount: 100, category_id: 1)
      expect(transaction).to respond_to(:author)
    end

    it 'belongs to a category' do
      transaction = Transaction.new(name: 'Expense', amount: 100, category_id: 1)
      expect(transaction).to respond_to(:category)
    end

    it 'has dependent destroy on category' do
      category = Category.create(name: 'Food')
      Transaction.create(name: 'Expense', amount: 100, category:, author: User.new)
      expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
