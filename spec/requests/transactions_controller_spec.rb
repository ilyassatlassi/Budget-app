require 'rails_helper'

RSpec.describe 'transactions', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'John', email: 'john@gmail.com', password: 'password') }
  let(:category) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let(:transaction) { Transaction.create!(author: user, name: 'Pizza', amount: 150, category:) }

  let(:valid_params) { { transaction: { category_id: category.id, name: 'Burger', amount: 100 } } }
  let(:invalid_params) { { transaction: { category_id: category.id, name: '', amount: 100 } } }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it 'should return a 200 OK status' do
      get new_category_transaction_path(category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render transactions/new template' do
      get new_category_transaction_path(category)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new transaction' do
        expect do
          post category_transactions_path(category), params: valid_params
        end.to change(Transaction, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'should not create a new transaction' do
        expect do
          post category_transactions_path(category), params: invalid_params
        end.to change(Transaction, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'should destroy the requested transaction' do
      new_transaction = Transaction.create!(author: user, category:, name: 'Sushi', amount: 30)
      expect do
        delete category_transaction_path(category, new_transaction)
      end.to change(Transaction, :count).by(-1)
    end
  end
end