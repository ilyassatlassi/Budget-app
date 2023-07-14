require 'rails_helper'

RSpec.feature 'Transaction Index', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Ilyass', email: 'ilyass@gmail.com', password: 'password') }
  let!(:category) { Category.create!(user:, name: 'Gym', icon: '🏋️‍♂️') }

  before do
    sign_in user
    visit category_transactions_path(category)
  end

  scenario 'displays a message when no transactions exist' do
    category.transactions.destroy_all
    visit category_transactions_path(category)

    expect(page).to have_content('No transactions found.')
    expect(page).not_to have_selector('.transactions-card')
  end
end
