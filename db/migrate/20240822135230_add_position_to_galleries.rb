class AddPositionToGalleries < ActiveRecord::Migration[7.1]
  def change
    add_column :galleries, :position, :integer
  end
end
