class AddDetailsToCuisines < ActiveRecord::Migration[6.0]
  def change
    add_column :cuisines, :name, :string
  end
end
