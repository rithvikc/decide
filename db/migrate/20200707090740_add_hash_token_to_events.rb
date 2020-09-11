class AddHashTokenToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :hash_token, :string
  end
end
