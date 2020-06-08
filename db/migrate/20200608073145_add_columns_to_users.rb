class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :allergies, :string
    add_column :users, :avatar, :string
  end
end
