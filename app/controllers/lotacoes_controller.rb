class LotacoesController < ApplicationController
    before_action :set_lotacao, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    respond_to :html

    def index
        @search = Lotacao.ransack(params[:q])

        if params[:q].nil?
            @lotacoes = Lotacao.order("codigo desc")
            authorize @lotacoes
        else
            @lotacoes = @search.result
            authorize @lotacoes
        end

        @search.build_condition if @search.conditions.empty?
        @search.build_sort if @search.sorts.empty?
    end

    def lista_lotacoes
        @search = Lotacao.ransack(params[:q])

        if params[:q].nil?
            @lotacoes = Lotacao.order("id desc")
        else
            @lotacoes = @search.result
        end

        respond_to do |format|
            format.pdf {
                render pdf: "Lista de Lotações",
                title: 'Lista de Lotações',
                :show_as_html => false,
                :page_size => "A4",
                :orientation => "Landscape",
                :disposition => "inline",
                :template => "reports/lista_lotacoes.pdf.erb",
                :margin => {:top => 30, :bottom => 30},
                header: { html: { template: 'reports/templates/header.pdf.erb'}, :spacing => 5},
                footer: { html: { template: 'reports/templates/footer.pdf.erb'}}
            }
        end
    end

    def importar_txt
        msg, salvo = ImportTxt.importar_txt(params[:txt].tempfile, current_user.id, params[:txt].original_filename, "lotacoes")

        respond_to do |format|
            if salvo == :success
                format.html { redirect_to lotacoes_path, notice: msg }
            else
                format.html { redirect_to lotacoes_path, flash: { error: msg } }
            end
        end
    end

    def buscar_lotacao
        @lotacoes = Lotacao.where('upper(descricao) like upper(?)', "%#{params[:descricao]}%")
    end

    def show
        respond_with(@lotacao)
    end

    def new
        @lotacao = Lotacao.new
        respond_with(@lotacao)
    end

    def edit
    end

    def create
        @lotacao = Lotacao.new(lotacao_params)
        @lotacao.save
        respond_with(@lotacao)
    end

    def update
        @lotacao.update(lotacao_params)
        respond_with(@lotacao)
    end

    def destroy
        @lotacao.destroy
        respond_with(@lotacao)
    end

    private
    def set_lotacao
        @lotacao = Lotacao.find(params[:id])
    end

    def lotacao_params
        params.require(:lotacao).permit(:codigo, :descricao)
    end
end