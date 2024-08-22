class AddCategoryRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :category, index: true, foreign_key: true
  end
end
