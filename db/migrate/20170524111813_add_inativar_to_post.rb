class AddInativarToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :inativar, :boolean
  end
end
