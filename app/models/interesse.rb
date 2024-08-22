class Interesse
 include ActiveAttr::Model

 model_name.instance_variable_set(:@route_key, 'interesse')
 attribute :nome
 attribute :email
 attribute :telefone
 attribute :mensagem
 attribute :interesse

 validates_presence_of :nome, :telefone, :mensagem
 validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
 validates_length_of :mensagem, :maximum => 2000

end
