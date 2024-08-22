class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|

      t.timestamps null: false
    end
  end
end
