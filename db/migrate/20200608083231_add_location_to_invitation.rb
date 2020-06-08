class AddLocationToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :location, :string
  end
end
