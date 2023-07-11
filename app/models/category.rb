class Category < ApplicationRecord
    belongs_to :user
    has_many :categories_transactions
    has_many :transactions, through: :transaction_categories
  
    validates :name, presence: true
    validates :icon, presence: true
  end