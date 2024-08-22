class Category < ActiveRecord::Base
  has_many :posts,  dependent: :destroy

  def ativo_inativo
    if inativar?
      "Inativo"
    else
      "Ativo"
    end
  end
end
