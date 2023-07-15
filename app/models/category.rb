class Category < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :icon, presence: true

  def total_amount
    transactions.sum(:amount)
  end
end
