class AddForeignerToParticipanteAndDependente < ActiveRecord::Migration
	def change
		add_foreign_key :dependentes, :participantes
        add_foreign_key :dependentes, :users

        add_foreign_key :participantes, :users        
	end
end
