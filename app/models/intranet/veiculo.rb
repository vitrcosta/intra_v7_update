class Intranet::Veiculo < ApplicationRecord
  has_one_attached :foto_principal

  has_many_attached :fotos

  def ativo_inativo
    if inativo
      "Inativo"
    else
      "Ativo"
    end
  end
end
