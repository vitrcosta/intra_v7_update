class Gallery < ActiveRecord::Base
  default_scope { order(:position) }
  belongs_to :post
  belongs_to :veiculo
  has_one_attached :image

  def remover_foto(remover)
    self.destroy if remover
  end
end
