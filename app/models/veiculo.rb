class Veiculo < ApplicationRecord
  has_one_attached :foto_principal

  has_many :galleries
  accepts_nested_attributes_for :galleries , allow_destroy: true

  def ativo_inativo
    if inativo
      "Inativo"
    else
      "Ativo"
    end
  end
end
