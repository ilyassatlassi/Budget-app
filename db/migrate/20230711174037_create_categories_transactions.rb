class CreateCategoriesTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_transactions, id: false do |t|
      t.references :category, null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true
    end
  end
end
