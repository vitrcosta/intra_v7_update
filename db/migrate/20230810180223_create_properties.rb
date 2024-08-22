class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :client
      t.string :code

      t.timestamps null: false
    end
  end
end
