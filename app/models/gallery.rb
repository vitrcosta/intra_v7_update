class Gallery < ActiveRecord::Base

  belongs_to :post
  has_one_attached :image

  def remover_foto(remover)
    self.destroy if remover
  end
end
