class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :titulo
      t.string :subtitulo
      t.text :descricao
      t.date :data

      t.timestamps null: false
    end
  end
end
