class CategoryTransaction < ApplicationRecord
    # belongs_to :transaction, foreign_key: 'transaction_id', dependent: :destroy
    # belongs_to :category, foreign_key: 'category_id', dependent: :destroy
  end
