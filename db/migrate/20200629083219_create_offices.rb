class CreateOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :name_2
      t.string :postalcode
      t.string :phonenumber
      t.string :phonenumber_2
      t.string :opt_info
      t.string :opt_info_2
      t.timestamps
    end
  end
end
