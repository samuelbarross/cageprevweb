class Lotacao < ActiveRecord::Base
	validates :codigo, length: {maximum: 20} , presence: true
	validates :descricao, length: {maximum: 255} , presence: true

	has_many :participantes

    UNRANSACKABLE_ATTRIBUTES = ["id", "codigo", "descricao"]  

    def self.ransackable_attributes auth_object = nil
        (UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end	
end
