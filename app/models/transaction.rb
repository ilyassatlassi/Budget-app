class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User'

  belongs_to :category
  validates :name, presence: true
  validates :amount, presence: true
  validates :category, presence: true
  validate :belongs_to_a_category

  def belongs_to_a_category
    errors.add(:category_id, 'must belong to a category') unless category_id && category
  end
end
