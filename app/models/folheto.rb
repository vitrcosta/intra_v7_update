class Folheto < ActiveRecord::Base

  has_one_attached :imagem_folheto

  def remover_imagem_folheto(remover)
    self.imagem_folheto.destroy if remover
  end


end
