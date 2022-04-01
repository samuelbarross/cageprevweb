class Dependente < ActiveRecord::Base
	belongs_to :participante

	validates :sexo, :parentesco, presence: true
	validates :nome, length: {maximum: 255}, presence: true
	validates_inclusion_of :invalido, in: [true, false]
	
	enum sexo: { masculino: 1, feminino: 2 }
	enum parentesco: { participante: 0, ex_conjugue_percepcao_alimentos: 9,  companheiro: 10, filho: 11, filho_invalido: 12, pais: 13, irmao: 14, irmao_invalido: 15, conjugue: 16, menor_sob_guarda: 17 }

    UNRANSACKABLE_ATTRIBUTES = ["id", "participante_id", "user_id", "sexo", "parentesco", "invalido", "created_at", "updated_at"]

    def self.ransackable_attributes auth_object = nil
        (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end  		
end
