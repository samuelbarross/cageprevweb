class ParticipantesController < ApplicationController
    before_action :set_participante, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    respond_to :html

    def index
        @search = Participante.ransack(params[:q])

        if params[:q].nil?
            @participantes = Participante.includes(:estado).includes(:lotacao).limit(100).order("id desc")
            authorize @participantes
        else
            @participantes = @search.result.includes(:estado).includes(:lotacao).order("id desc")
            authorize @participantes
        end

        @search.build_condition if @search.conditions.empty?
        @search.build_sort if @search.sorts.empty?
    end

    def lista_participantes
        @search = Participante.ransack(params[:q])

        if params[:q].nil?
            @participantes = Participante.limit(100).includes(:estado).includes(:lotacao).order("id desc")
        else
            @participantes = @search.result.limit(100).includes(:estado).includes(:lotacao)
        end

        respond_to do |format|
            format.pdf {
                render pdf: "Lista de Participantes",
                title: 'Lista de Participantes',
                :show_as_html => false,
                :page_size => "A4",
                :orientation => "Landscape",
                :disposition => "inline",
                :template => "reports/lista_participantes.pdf.erb",
                :margin => {:top => 30, :bottom => 30},
                header: { html: { template: 'reports/templates/header.pdf.erb'}, :spacing => 5},
                footer: { html: { template: 'reports/templates/footer.pdf.erb'}}
            }
        end
    end

    def importar_txt
        msg, salvo = ImportTxt.importar_txt(params[:txt].tempfile, current_user.id, params[:txt].original_filename, "participantes")

        respond_to do |format|
            if salvo == :success
                format.html { redirect_to participantes_path, notice: msg }
            else
                format.html { redirect_to participantes_path, flash: { error: msg } }
            end
        end
    end

    def download_txt
        begin
            search = Participante.ransack(params[:q])

            if params[:q].nil?
                participantes = Participante.includes(:estado).includes(:lotacao).order("nome asc")
            else
                participantes = search.result.includes(:estado).includes(:lotacao).order("nome asc")
            end

            data = ""

            participantes.each do |participante|
                data << participante.matricula
                data << '|' << participante.nome
                participante.nome_pai.present? ? data << '|' << participante.nome_pai : data << '|'
                participante.nome_mae.present? ? data << '|' << participante.nome_mae : data << '|'
                participante.nome_conjugue.present? ? data << '|' << participante.nome_conjugue : data << '|'
                data << '|' << participante.sexo.titlecase
                participante.naturalidade.present? ? data << '|' << participante.naturalidade : data << '|'
                participante.nacionalidade.present? ? data << '|' << participante.nacionalidade : data << '|'
                data << '|' <<  Participante.estado_civis[:"#{participante.estado_civil}"].to_s
                participante.data_nascimento.present? ? data << '|' << participante.data_nascimento.strftime("%m/%d/%Y") : data << '|'
                data << '|' << participante.cpf
                participante.rg.present? ? data << '|' << participante.rg : data << '|'
                participante.orgao_expedidor.present? ? data << '|' << participante.orgao_expedidor : data << '|'
                participante.data_expedicao.present? ? data << '|' << participante.data_expedicao.strftime("%m/%d/%Y") : data << '|'
                data << '|' << participante.logradouro
                participante.numero.present? ? data << '|' << participante.numero : data << '|'
                participante.complemento.present? ? data << '|' << participante.complemento : data << '|'
                participante.bairro.present? ? data << '|' << participante.bairro : data << '|'
                participante.cidade.present? ? data << '|' << participante.cidade : data << '|'
                participante.cep.present? ? data << '|' << participante.cep : data << '|'
                data << '|' << participante.estado.descricao << '-' << participante.estado.uf
                participante.data_posse.present? ? data << '|' << participante.data_posse.strftime("%m/%d/%Y") : data << '|'
                data << '|' << participante.cargo
                data << '|' << participante.lotacao.descricao
                participante.telefone_residencial.present? ? data << '|' << participante.telefone_residencial.gsub(/\A(\+)|\D+/, '\1') : data << '|'
                participante.telefone_celular.present? ? data << '|' << participante.telefone_celular.gsub(/\A(\+)|\D+/, '\1') : data << '|'
                participante.email.present? ? data << '|' << participante.email : data << '|'
                data << ";\r\n"
            end
            send_data data, filename: "prticipantes-#{Time.new.strftime("%Y-%m-%d")}.txt", type: "text/plain;ISO-8859-1", disposition: 'attachment'
        rescue Exception => e
            respond_to do |format|
                format.html { redirect_to participantes_path, flash: { error: "#{e}" } }
            end
        end
    end

    def buscar_participante
        @participantes = Participante.where('upper(nome) like upper(?)', "%#{params[:nome]}%")
    end

    def show
        @dependentes = Dependente.where(participante_id: params[:id])
        @imagens = Imagem.where(participante_id: params[:id])
        respond_with(@participante)
    end

    def new
        @participante = Participante.new
        respond_with(@participante)
    end

    def edit
    end

    def create
        @participante = Participante.new(participante_params)
        @participante.save
        respond_with(@participante)
    end

    def update
        @participante.update(participante_params)
        respond_with(@participante)
    end

    def destroy
        @participante.destroy
        respond_with(@participante)
    end

    private
    def set_participante
        @participante = Participante.find(params[:id])
    end

    def participante_params
        valores  = params.require(:participante).permit(:estado_id, :lotacao_id, :matricula, :nome, :nome_pai, :nome_mae, :nome_conjugue, :sexo, :naturalidade, :nacionalidade, :estado_civil, :data_nascimento, :cpf, :rg, :orgao_expedidor, :data_expedicao, :logradouro, :numero, :complemento, :bairro, :cidade, :cep, :data_posse, :cargo, :telefone_residencial, :telefone_celular, :email,
            dependentes_attributes: [:id, :participante_id, :codigo, :nome, :sexo, :data_nascimento, :parentesco, :invalido, :_destroy],
            imagens_attributes: [:id, :images, :_destroy])

        valores[:cpf].gsub!(".","").gsub!("-", "")  if valores[:cpf].present?

        valores
    end
end