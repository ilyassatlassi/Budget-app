class CreateCategoriesTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_transactions do |t|

      t.timestamps
    end
  end
end
