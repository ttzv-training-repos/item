class AddLocationToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :location, :string
    add_column :offices, :location_2, :string
  end
end
