class DropGroupsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :groups
    drop_table :entities

  end
end
