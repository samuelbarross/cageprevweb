require 'test_helper'

class DependentesControllerTest < ActionController::TestCase
  setup do
    @dependente = dependentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependente" do
    assert_difference('Dependente.count') do
      post :create, dependente: { codigo: @dependente.codigo, data_nascimento: @dependente.data_nascimento, invalido: @dependente.invalido, nome: @dependente.nome, parentesco: @dependente.parentesco, participante_id: @dependente.participante_id, sexo: @dependente.sexo }
    end

    assert_redirected_to dependente_path(assigns(:dependente))
  end

  test "should show dependente" do
    get :show, id: @dependente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dependente
    assert_response :success
  end

  test "should update dependente" do
    patch :update, id: @dependente, dependente: { codigo: @dependente.codigo, data_nascimento: @dependente.data_nascimento, invalido: @dependente.invalido, nome: @dependente.nome, parentesco: @dependente.parentesco, participante_id: @dependente.participante_id, sexo: @dependente.sexo }
    assert_redirected_to dependente_path(assigns(:dependente))
  end

  test "should destroy dependente" do
    assert_difference('Dependente.count', -1) do
      delete :destroy, id: @dependente
    end

    assert_redirected_to dependentes_path
  end
end
