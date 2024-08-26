class CreateIntranetVeiculos < ActiveRecord::Migration[7.1]
  def change
    create_table :intranet_veiculos do |t|
      t.integer :ano
      t.string :modelo

      t.timestamps
    end
  end
end
