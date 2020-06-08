class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_at
      t.string :token

      t.timestamps
    end
  end
end
