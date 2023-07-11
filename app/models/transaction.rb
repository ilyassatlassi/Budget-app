class Transaction < ApplicationRecord
    belongs_to :author, class_name: 'User'
  
    has_many :categories_transactions
    has_many :categories, through: :transaction_categories
  
    validates :name, presence: true
    validates :amount, presence: true
  end
# class transactions < ApplicationRecord
#     # belongs_to :category
#     # belongs_to :author, class_name: 'User'
  
#     # validates :name, presence: true
#     # validates :category, presence: true
#     # validates :amount, presence: true, numericality: { greater_than: 0 }
#     # validate :belongs_to_a_category
  
#     # def belongs_to_a_category
#     #   errors.add(:category_id, 'must belong to a category') unless category_id && category
#     # end
#   end