class CreateKindOfPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :kind_of_posts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
