class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :titulo, use: :slugged

  belongs_to :kind_of_post
  belongs_to :category
  has_many :galleries
  accepts_nested_attributes_for :galleries , allow_destroy: true

  has_one_attached :foto_principal

  validates_presence_of  :titulo , :kind_of_post_id


  def remover_foto_principal(remover)
    self.foto_principal.destroy if remover
  end
  def remover_foto(remover)
    self.foto.destroy if remover
  end

  def ativo_inativo
    if inativar?
      "Inativo"
    else
      "Ativo"
    end
  end


end
