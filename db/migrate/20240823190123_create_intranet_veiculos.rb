class CreateIntranetVeiculos < ActiveRecord::Migration[7.1]
  def change
    create_table :intranet_veiculos do |t|
      t.integer :ano
      t.string :modelo
      t.decimal :preco, precision: 12, scale: 2
      t.text :observacao
      t.text :descricao
      t.integer :quilometragem
      t.string :cor
      t.string :anofab
      t.string :combustivel
      t.string :procedencia
      t.boolean :inativo
      t.boolean :destaque
      t.integer :codigo
      t.string :versao
      t.string :placa

      t.timestamps
    end
  end
end
