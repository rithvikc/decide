class RemoveAddressFromInvitations < ActiveRecord::Migration[6.0]
  def up
    remove_column :invitations, :address
  end
end
