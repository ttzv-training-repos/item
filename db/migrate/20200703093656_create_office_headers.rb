class CreateOfficeHeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :office_headers do |t|
      t.string :name
      t.string :name_en

      t.timestamps
    end
  end
end
