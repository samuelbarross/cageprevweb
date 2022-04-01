class DependentesController < ApplicationController
    before_action :set_dependente, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    respond_to :html

    def index
        @search = Dependente.ransack(params[:q])

        if params[:q].nil?
            if current_user.role = 1
                @dependentes = Dependente.includes(:participante).limit(100).order("id desc")
            else
                participante = Participante.find_by_cpf(current_user.cpf)
                @dependentes = Dependente.includes(:participante).where(participante_id: participante).limit(100).order("id desc")
            end
            # authorize @dependentes
        else
            @dependentes = @search.result.includes(:participante).order("id desc")
            # authorize @dependentes
        end

        @search.build_condition if @search.conditions.empty?
        @search.build_sort if @search.sorts.empty?       
    end

    def lista_dependentes
        @search = Dependente.ransack(params[:q])

        if params[:q].nil?
            @dependentes = Dependente.limit(100).includes(:participante).order("id desc")
        else
            @dependentes = @search.result.limit(100).includes(:participante)
        end

        respond_to do |format|
            format.pdf {
                render pdf: "Lista de Dependentes",
                title: 'Lista de Dependentes',
                :show_as_html => false,
                :page_size => "A4",
                :orientation => "Landscape",
                :disposition => "inline",
                :template => "reports/lista_dependentes.pdf.erb",
                :margin => {:top => 30, :bottom => 30},
                header: { html: { template: 'reports/templates/header.pdf.erb'}, :spacing => 5},
                footer: { html: { template: 'reports/templates/footer.pdf.erb'}}
            }
        end
    end

    def importar_txt
        msg, salvo = ImportTxt.importar_txt(params[:txt].tempfile, current_user.id, params[:txt].original_filename, "dependentes")

        respond_to do |format|
            if salvo == :success
                format.html { redirect_to dependentes_path, notice: msg }
            else
                format.html { redirect_to dependentes_path, flash: { error: msg } }
            end
        end
    end

    def download_txt
        begin
            search = Dependente.ransack(params[:q])

            if params[:q].nil?
                dependentes = Dependente.includes(:participante).order("nome asc")
            else
                dependentes = search.result.includes(:participante).order("nome asc")
            end

            data = ""

            dependentes.each do |dependente|
                data << dependente.codigo
                data << '|' << dependente.participante.matricula
                data << '|' << dependente.nome
                data << '|' << dependente.sexo.titlecase
                dependente.data_nascimento.present? ? data << '|' << dependente.data_nascimento.strftime("%m/%d/%Y") : data << '|'
                data << '|' <<  Dependente.parentescos[:"#{dependente.parentesco}"].to_s
                dependente.invalido.nil? ? data << '|' : (dependente.invalido ? data << '|' << "SIM" : data << '|' << "FALSO")
                data << ";\r\n"
            end
            send_data data, filename: "dependentes-#{Time.new.strftime("%Y-%m-%d")}.txt", type: "text/plain;ISO-8859-1", disposition: 'attachment'
        rescue Exception => e
            respond_to do |format|
                format.html { redirect_to dependentes_path, flash: { error: "#{e}" } }
            end
        end
    end

    def show
        respond_with(@dependente)
    end

    def new
        @dependente = Dependente.new
        respond_with(@dependente)
    end

    def edit
    end

    def create
        @dependente = Dependente.new(dependente_params)
        @dependente.save
        respond_with(@dependente)
    end

    def update
        @dependente.update(dependente_params)
        respond_with(@dependente)
    end

    def destroy
        @dependente.destroy
        respond_with(@dependente)
    end

    private
    def set_dependente
        @dependente = Dependente.find(params[:id])
    end

    def dependente_params
        params.require(:dependente).permit(:participante_id, :codigo, :nome, :sexo, :data_nascimento, :parentesco, :invalido)
    end
end