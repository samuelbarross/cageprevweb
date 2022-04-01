class Estado < ActiveRecord::Base

	validates :codigo, length: {maximum: 10} , presence: true
	validates :descricao, length: {maximum: 255} , presence: true
	validates :uf, length: {maximum: 2} , presence: true

	has_many :participantes
	
    UNRANSACKABLE_ATTRIBUTES = ["id", "codigo", "descricao"]  

    def self.ransackable_attributes auth_object = nil
        (UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end
end
