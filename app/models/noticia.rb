class Noticia < ActiveRecord::Base

  has_attached_file :foto, :styles =>{:thumb =>"158x69#", :medium =>"#754x", :destaque =>'347x150#',:carrossel =>'250x134#'}, :convert_options => { :thumb => "-crop 840x615+0+0" , :carrossel => "-crop 250x134+0+0" }
  do_not_validate_attachment_file_type :foto

  def remover_foto(remover)
    self.foto.destroy if remover
  end
  scope :sort_by_data, lambda{|direction|
    order "data #{direction} "
  }
  validates_presence_of  :titulo, :data, :texto

  def self.search(type, search)
    if type and search
      where(type + ' LIKE ?', "%#{search}%")
    else
      all
    end
  end


end
