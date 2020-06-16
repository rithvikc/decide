class AddDecidedToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :decided, :boolean, default: false
  end
end
