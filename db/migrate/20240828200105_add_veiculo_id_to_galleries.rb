class AddVeiculoIdToGalleries < ActiveRecord::Migration[7.1]
  def change
    add_reference :galleries, :veiculo, null: false, foreign_key: true
  end
end
