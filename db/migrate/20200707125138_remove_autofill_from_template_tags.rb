class RemoveAutofillFromTemplateTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :template_tags, :autofill
  end
end
