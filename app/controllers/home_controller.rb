class HomeController < ApplicationController
	def index
		@mainTitle = "Bem-Vindo ao CagePrev-Web"
		@mainDesc = ""

		participante = Participante.find_by_cpf(current_user.cpf)

		if participante
			respond_to do |format|
				format.html { redirect_to participante_path(participante), notice: 'Participante encontrato' }
			end
		else
			@mainDesc = "Participante não cadastrado!!"
		end
	end

 	 def minor
  	end
end
