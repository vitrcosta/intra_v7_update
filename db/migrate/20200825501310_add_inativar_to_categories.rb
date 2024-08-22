class AddInativarToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :inativar, :boolean
  end
end
