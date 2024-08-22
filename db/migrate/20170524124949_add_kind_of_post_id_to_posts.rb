class AddKindOfPostIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :kind_of_post_id, :integer
  end
end
