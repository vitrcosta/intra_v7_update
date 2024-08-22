class AddKeywordsToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :keywords, :string
  end
end
