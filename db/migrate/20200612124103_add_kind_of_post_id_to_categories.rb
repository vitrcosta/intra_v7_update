class AddKindOfPostIdToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :kind_of_posts_id, :integer
  end
end
