class Category < ApplicationRecord
    has_many :transactions
    belongs_to :user
  
    validates :name, presence: true, length: { maximum: 30 }
    validates :icon, presence: true
  
    def total_expense
        transactions.sum(:amount)
    end
  end