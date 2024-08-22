class Cliente < ActiveRecord::Base
  before_create :default_status

  def default_status
    self.status = 1 #status: aberto
  end

  def self.search(search)
    if search
      where('nome LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.search_status(status)
    if(status.blank?)
      all
    else
      where(:status => status)
    end
  end
  def self.search_atendente(atendente)
    if(atendente.blank?)
      all
    else
      where("atendido_por LIKE ?" , "%" + atendente + "%")
    end
  end

  def self.search_data(de,ate)
    if de.nil? || ate.nil?
      all
    elsif de.nil?
      where(created_at: DateTime.strptime("01/01/2016", "%d/%m/%Y").beginning_of_day..DateTime.strptime(ate, "%d/%m/%Y").end_of_day)
    elsif ate.nil?
      where(created_at: DateTime.strptime(de, "%d/%m/%Y").beginning_of_day..Date.today)
    else
      where(created_at: DateTime.strptime(de, "%d/%m/%Y").beginning_of_day..DateTime.strptime(ate, "%d/%m/%Y").end_of_day)
    end
  end
end
