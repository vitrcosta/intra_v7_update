class Gallery < ActiveRecord::Base
  default_scope { order(:position) }
  belongs_to :post
  belongs_to :intranet_veiculo, class_name: 'Intranet::Veiculo', foreign_key: 'intranet_veiculo_id'
  has_one_attached :image

  def remover_foto(remover)
    self.destroy if remover
  end
end
