require 'test_helper'

class ParticipantesControllerTest < ActionController::TestCase
  setup do
    @participante = participantes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participante" do
    assert_difference('Participante.count') do
      post :create, participante: { bairro: @participante.bairro, cargo: @participante.cargo, cep: @participante.cep, cidade: @participante.cidade, complemento: @participante.complemento, cpf: @participante.cpf, data_expedicao: @participante.data_expedicao, data_nascimento: @participante.data_nascimento, data_posse: @participante.data_posse, email: @participante.email, estado_civil: @participante.estado_civil, estado_id: @participante.estado_id, logradouro: @participante.logradouro, lotacao_id: @participante.lotacao_id, matricula: @participante.matricula, nacionalidade: @participante.nacionalidade, naturalidade: @participante.naturalidade, nome: @participante.nome, nome_conjugue: @participante.nome_conjugue, nome_mae: @participante.nome_mae, nome_pai: @participante.nome_pai, numero: @participante.numero, orgao_expedidor: @participante.orgao_expedidor, rg: @participante.rg, sexo: @participante.sexo, telefone_celular: @participante.telefone_celular, telefone_residencial: @participante.telefone_residencial }
    end

    assert_redirected_to participante_path(assigns(:participante))
  end

  test "should show participante" do
    get :show, id: @participante
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participante
    assert_response :success
  end

  test "should update participante" do
    patch :update, id: @participante, participante: { bairro: @participante.bairro, cargo: @participante.cargo, cep: @participante.cep, cidade: @participante.cidade, complemento: @participante.complemento, cpf: @participante.cpf, data_expedicao: @participante.data_expedicao, data_nascimento: @participante.data_nascimento, data_posse: @participante.data_posse, email: @participante.email, estado_civil: @participante.estado_civil, estado_id: @participante.estado_id, logradouro: @participante.logradouro, lotacao_id: @participante.lotacao_id, matricula: @participante.matricula, nacionalidade: @participante.nacionalidade, naturalidade: @participante.naturalidade, nome: @participante.nome, nome_conjugue: @participante.nome_conjugue, nome_mae: @participante.nome_mae, nome_pai: @participante.nome_pai, numero: @participante.numero, orgao_expedidor: @participante.orgao_expedidor, rg: @participante.rg, sexo: @participante.sexo, telefone_celular: @participante.telefone_celular, telefone_residencial: @participante.telefone_residencial }
    assert_redirected_to participante_path(assigns(:participante))
  end

  test "should destroy participante" do
    assert_difference('Participante.count', -1) do
      delete :destroy, id: @participante
    end

    assert_redirected_to participantes_path
  end
end
