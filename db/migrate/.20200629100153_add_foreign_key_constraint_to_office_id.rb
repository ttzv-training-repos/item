class AddForeignKeyConstraintToOfficeId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :ad_user_details, :offices, column: :office_id
  end
end
