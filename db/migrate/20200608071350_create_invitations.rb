class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :status
      t.references :cuisine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
