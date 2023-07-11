class categories_transactions < ApplicationRecord
    belongs_to :transaction, foreign_key: 'its_transaction_id'
    belongs_to :category, foreign_key: 'category_id'
  end