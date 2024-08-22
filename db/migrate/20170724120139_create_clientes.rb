class CreateClientes < ActiveRecord::Migration[7.1]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :curso
      t.text :mensagem
      t.integer :status
      t.string :atendido_por

      t.timestamps null: false
    end
  end
end
