class AddCoordinatesToInterviews < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :latitude, :float
    add_column :invitations, :longitude, :float
    add_column :invitations, :address, :string
  end
end
