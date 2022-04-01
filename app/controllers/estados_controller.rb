class EstadosController < ApplicationController
    before_action :set_estado, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!

    respond_to :html

    def index
        @search = Estado.ransack(params[:q])

        if params[:q].nil?
            @estados = Estado.limit(100).order("codigo  desc")
            authorize @estados
        else
            @estados = @search.result
            authorize @estados
        end

        @search.build_condition if @search.conditions.empty?
        @search.build_sort if @search.sorts.empty?
    end

    def buscar_estado
        @estados = Estado.where('upper(descricao) like upper(?)', "%#{params[:descricao]}%")
    end

    def importar_txt
        msg, salvo = ImportTxt.importar_txt(params[:txt].tempfile, current_user.id, params[:txt].original_filename, "estados")

      respond_to do |format|
         if salvo == :success
            format.html { redirect_to estados_path, notice: msg }
         else
            format.html { redirect_to estados_path, flash: { error: msg } }
         end
      end
    end

    def show
        respond_with(@estado)
    end

    def new
        @estado = Estado.new
        respond_with(@estado)
    end

    def edit
        authorize @estados
    end

    def create
        @estado = Estado.new(estado_params)
        @estado.save
        respond_with(@estado)
    end

    def update
        @estado.update(estado_params)
        respond_with(@estado)
    end

    def destroy
        @estado.destroy
        respond_with(@estado)
    end

    private
    def set_estado
        @estado = Estado.find(params[:id])
    end

    def estado_params
        params.require(:estado).permit(:codigo, :descricao, :uf)
    end
end