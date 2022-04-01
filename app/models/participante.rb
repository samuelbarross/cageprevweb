class Participante < ActiveRecord::Base
 	belongs_to :estado
  	belongs_to :lotacao

    has_many :dependentes, dependent: :destroy
    has_many :imagens, dependent: :destroy

    accepts_nested_attributes_for :dependentes, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :imagens, allow_destroy: true, reject_if: :all_blank

    EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

    validates :matricula, length: {maximum: 20}, uniqueness: true, presence: true
    validates :nome, :nome_mae, length: {maximum: 60}, presence: true
    validates :naturalidade, :nacionalidade, :bairro, :cidade, length: {maximum: 40}
    validates :nome_pai, :nome_conjugue, :email, :cargo, length: {maximum: 60}, allow_blank: true
    validates :data_posse, :sexo, :lotacao_id, presence: true
    validates :cpf, length: {maximum: 11}, allow_blank: true, uniqueness: true, presence: true
    validates :rg, :orgao_expedidor, :cep, :telefone_residencial, :telefone_celular, length: {maximum: 20}, allow_blank: true
    validates :complemento, :logradouro, length: {maximum: 100}, allow_blank: true
    validates :numero, length: {maximum: 10}, allow_blank: true
    validates :email, length: {maximum: 60}, allow_blank: true, format: EMAIL_REGEXP

    enum sexo: { masculino: 1, feminino: 2 }
    enum estado_civil: { casado: 1, separado: 2, viuvo: 3, solteiro: 4, outros: 5}
    
    UNRANSACKABLE_ATTRIBUTES = ["id", "estado_id", "lotacao_id", "user_id", "nome_pai", "rg", "nome_conjugue", "sexo", "naturalidade", "nacionalidade", "estado_civil", "orgao_expedidor",
      "data_expedicao", "logradouro", "numero", "complemento", "bairro", "cidade", "cep", "telefone_residencial", "telefone_celular", "email", "created_at", "updated_at"]

    def self.ransackable_attributes auth_object = nil
        (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end  	
end