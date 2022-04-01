# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'samuel@swind.com.br', password: '82558237', password_confirmation: '82558237')
Empresa.create(cpf_cnpj: '60110574000144', nome: 'SWS') # cnpj fake
UsuarioEmpresa.create(user_id: 1, empresa_id: 1)

###################################################################################################