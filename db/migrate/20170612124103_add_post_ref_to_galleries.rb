class AddPostRefToGalleries < ActiveRecord::Migration[7.1]
  def change
    add_reference :galleries, :post, index: true, foreign_key: true
  end
end
