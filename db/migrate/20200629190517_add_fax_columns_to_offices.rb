class AddFaxColumnsToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :fax, :string 
    add_column :offices, :fax_2, :string
  end
end
