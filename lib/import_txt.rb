class ImportTxt
	def self.importar_txt(arquivo, user_id, file_name, conteudo)
		accepted_formats = [".txt"]
		arr = []
		if accepted_formats.include? File.extname(file_name)
			# File.read(arquivo, :encoding => 'utf-8').each_line do |line|
			File.read(arquivo, :encoding => 'ISO-8859-1').each_line do |line|
				# line.force_encoding("ISO-8859-1")
				# line.encode("UTF-8", invalid: :replace, undef: :replace)
				if line.presence
					arr = line.split("|")
					case conteudo
					when "estados"
						estado = Estado.find_by_codigo(arr[0])

						if estado
							estado.descricao = arr[1] unless arr[1].blank? 
							estado.uf = arr[2].gsub(";", "").squish unless arr[2].blank?
							estado.save 
						else
							estado = Estado.new
							estado.codigo = arr[0] unless arr[0].blank?
							estado.descricao = arr[1] unless arr[1].blank?
							estado.uf = arr[2].gsub(";", "").squish unless arr[2].blank?
							estado.save
						end
					when "lotacoes"
						lotacao = Lotacao.find_by_codigo(arr[0])

						if lotacao
							lotacao.descricao = arr[1].gsub(";", "").squish unless arr[1].blank?
							estado.save 
						else
							lotacao = Lotacao.new
							lotacao.codigo = arr[0] unless arr[0].blank?
							lotacao.descricao = arr[1].gsub(";", "").squish unless arr[1].blank?
							lotacao.save
						end
					when "participantes"
						participante = Participante.find_by_matricula(arr[0])

						if participante
							participante.nome = arr[1].squish unless arr[1].blank?
							participante.nome_pai = arr[2].squish unless arr[2].blank?
							participante.nome_mae = arr[3].squish unless arr[3].blank?
							participante.nome_conjugue = arr[4].squish unless arr[4].blank?
							participante.sexo =  arr[5].squish.downcase unless arr[5].blank?
							participante.naturalidade = arr[6].squish unless arr[6].blank?
							participante.nacionalidade = arr[7].squish unless arr[7].blank?
							participante.estado_civil = arr[8].squish.to_i unless arr[8].blank?
							participante.data_nascimento = arr[9].squish unless arr[9].blank?
							participante.cpf = arr[10].squish unless arr[10].blank?
							participante.rg = arr[11].squish unless arr[11].blank?
							participante.orgao_expedidor = arr[12].squish unless arr[12].blank?
							participante.data_expedicao = arr[13].squish unless arr[13].blank?
							participante.logradouro = arr[14].squish unless arr[14].blank?
							participante.numero = arr[15].squish unless arr[15].blank?
							participante.complemento = arr[16].squish unless arr[16].blank?
							participante.bairro = arr[17].squish unless arr[17].blank?
							participante.cidade = arr[18].squish unless arr[18].blank?
							participante.cep = arr[19].squish unless arr[19].blank?
							estado = Estado.find_by_codigo(arr[20]) unless arr[20].blank?
							participante.estado_id = estado.id if estado
							participante.data_posse = arr[21].squish unless arr[21].blank?
							participante.cargo = arr[22].squish unless arr[22].blank?
							lotacao = Lotacao.find_by_codigo(arr[23]) unless arr[23].blank?
							participante.lotacao_id = lotacao.id if lotacao
							participante.telefone_residencial = arr[24].squish unless arr[24].blank?
							participante.telefone_celular = arr[25].squish unless arr[25].blank?
							email = arr[26].gsub(";", "") unless arr[26].blank?
							email.blank? ? participante.email = nil : participante.email = email.strip

							participante.save

							user = User.find_by_cpf(arr[10].squish)

							unless user.nil?
								email = arr[26].gsub(";", "") unless arr[26].blank?
								user.email = email.strip unless email.blank?
								user.save(validate: false)
							end
						else
							participante = Participante.new
							participante.matricula = arr[0].strip unless arr[0].blank?
							participante.nome = arr[1].squish unless arr[1].blank?
							participante.nome_pai = arr[2].squish unless arr[2].blank?
							participante.nome_mae = arr[3].squish unless arr[3].blank?
							participante.nome_conjugue = arr[4].squish unless arr[4].blank?
							participante.sexo =  arr[5].squish.downcase unless arr[5].blank?
							participante.naturalidade = arr[6].squish unless arr[6].blank?
							participante.nacionalidade = arr[7].squish unless arr[7].blank?
							participante.estado_civil = arr[8].squish.to_i unless arr[8].blank?
							participante.data_nascimento = arr[9].squish unless arr[9].blank?
							participante.cpf = arr[10].squish unless arr[10].blank?
							participante.rg = arr[11].squish unless arr[11].blank?
							participante.orgao_expedidor = arr[12].squish unless arr[12].blank?
							participante.data_expedicao = arr[13].squish unless arr[13].blank?
							participante.logradouro = arr[14].squish unless arr[14].blank?
							participante.numero = arr[15].squish unless arr[15].blank?
							participante.complemento = arr[16].squish unless arr[16].blank?
							participante.bairro = arr[17].squish unless arr[17].blank?
							participante.cidade = arr[18].squish unless arr[18].blank?
							participante.cep = arr[19].squish unless arr[19].blank?
							estado = Estado.find_by_codigo(arr[20]) unless arr[20].blank?
							participante.estado_id = estado.id if estado 
							participante.data_posse = arr[21].squish unless arr[21].blank?
							participante.cargo = arr[22].squish unless arr[22].blank?
							lotacao = Lotacao.find_by_codigo(arr[23]) unless arr[23].blank?
							participante.lotacao_id = lotacao.id if lotacao
							participante.telefone_residencial = arr[24].squish unless arr[24].blank?
							participante.telefone_celular = arr[25].squish unless arr[25].blank?
							email = arr[26].gsub(";", "") unless arr[26].blank?
							participante.email = email.strip unless email.blank?
							participante.user_id = user_id

							participante.save(validate: false)

							user_model = User.find(10) # usuário padrão, só pra da o start em novos usuários
							user = User.find_by_cpf(arr[10].squish)

							if user.nil?
								user = User.new

								email = arr[26].gsub(";", "") unless arr[26].blank?
								user.email = email.strip unless email.blank?
								user.encrypted_password = user_model.encrypted_password
								user.role = 0
								user.cpf = arr[10] unless arr[10].blank?

								user.save(validate: false)

								usuario_empresa = UsuarioEmpresa.new

								usuario_empresa.user_id = user.id
								usuario_empresa.empresa_id = 1

								usuario_empresa.save
							end
						end
					when "dependentes"
						dependente = Dependente.find_by_codigo(arr[0].strip)

						if dependente
							participante = Participante.find_by_matricula(arr[1])
							if participante
								dependente.codigo = arr[0].squish unless arr[0].blank?
								dependente.nome = arr[2].strip unless arr[2].blank?
								dependente.sexo = arr[3].squish.downcase unless arr[3].blank?
								dependente.data_nascimento = arr[4].squish	unless arr[4].blank?
								dependente.parentesco = arr[5].squish.to_i	unless arr[5].blank?
								dependente.user_id = user_id

								unless arr[6].blank?
									if arr[6].strip.upcase.gsub(";","") == "FALSO"
										dependente.invalido = false
									else
										dependente.invalido = true
									end
								end

								dependente.save
							end
						else
							participante = Participante.find_by_matricula(arr[1].strip)

							if participante
								dependente = Dependente.new
								dependente.participante_id = participante.id
								dependente.codigo = arr[0].squish unless arr[0].blank?
								dependente.nome = arr[2].strip unless arr[2].blank?
								dependente.sexo = arr[3].squish.downcase unless arr[3].blank?
								dependente.data_nascimento = arr[4].squish	unless arr[4].blank?
								dependente.parentesco = arr[5].squish.to_i	unless arr[5].blank?
								dependente.user_id = user_id

								unless arr[6].blank?
									if arr[6].strip.upcase.gsub(";","") == "FALSO"
										dependente.invalido = false
									else
										dependente.invalido = true
									end
								end
							
								dependente.save(validate: false)
							end
						end
					end
				end
			end   
			return "Arquivo importado com sucesso", :success
		else
			return "Arquivo com formato inválido!", :error
		end
	end
end