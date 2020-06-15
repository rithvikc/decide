class AddLastEventToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_event, :integer
  end
end
