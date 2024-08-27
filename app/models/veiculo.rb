class Veiculo < ActiveRecord::Base

  # has_many :opcionals, through: :veiculo_opcionals
  # has_many :veiculo_opcionals, dependent: :destroy

  # has_many :fotos, dependent: :destroy
  # accepts_nested_attributes_for :fotos, :allow_destroy => true
  # validates_presence_of :ano , :modelo , :tipo_id , :marca_id ,:preco


  has_one_attached :foto_principal

  has_many_attached :fotos




  def set_codigo
    "seminovos/img/semi#{self.codigo}/img1.jpg"
  end

  def self.search(type, search)
    if type and search
      where(type + ' LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def get_carrodopovo_opcionais
    self.opcionals.where.not(tag_carrodopovo: nil)
  end

  def status_veiculo
    if self.inativo?
      "Inativo"
    else
      "Ativo"
    end
  end

  def metasub
    #(self.observacao.nil?) ? '' : view_context.strip_tags(veiculo.observacao.gsub(/\r\n\z/,''))
  end

  scope :destaque_semana, ->{ where destaque_semana: true }


  scope :busca, lambda{|modelo|
    return all unless modelo.present?
    where("modelo LIKE ?", "%#{modelo}%")
  }

  scope :by_marca, lambda{|marca_id|
    return all unless marca_id.present?
    where('marca_id=?', marca_id)
  }
  scope :by_tipo, lambda{|tipo_id|
    return all unless tipo_id.present?
    where('tipo_id=?', tipo_id)
  }

  scope :by_modelo, lambda{|modelo|
    return all unless modelo.present?
    where('modelo like ?', "%#{modelo}%")
  }

  scope :by_preco, lambda{|preco_min, preco_max|
    return all unless preco_min.present?
    where(preco: preco_min..preco_max)
  }

  scope :by_km, lambda{|km_min, km_max|
    return all unless km_min.present?
    where(quilometragem: km_min..km_max)
  }

  scope :by_ano, lambda{|ano_min, ano_max|
    return all unless ano_min.present?
    where(ano: ano_min..ano_max)
  }

  scope :sort_by_preco, lambda{|direction|
     order "preco #{direction} "
  }

  scope :sort_by_ano, lambda{|direction|
    order "ano #{direction} "
  }
  def self.filter(veiculo_params)
    preco = veiculo_params[:price_range].split ';' if veiculo_params[:price_range]
    #km = veiculo_params[:miliage].split ';' if veiculo_params[:miliage]
    ano = veiculo_params[:year_range].split ';' if veiculo_params[:year_range]

    by_tipo(veiculo_params[:tipo_id]).by_marca(veiculo_params[:marca_id]).by_modelo(veiculo_params[:modelo]).by_preco(preco[0], preco[1]).by_ano(ano[0], ano[1]).sort_by_preco(veiculo_params[:sort_list])
  end

  #def modelo
  #  "#{self.modelo} - #{self.versao}"
  #end

end
