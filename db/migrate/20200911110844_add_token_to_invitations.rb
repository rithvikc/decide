class AddTokenToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :token, :string
  end
end
