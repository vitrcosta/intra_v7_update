require "test_helper"

class Intranet::VeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @intranet_veiculo = intranet_veiculos(:one)
  end

  test "should get index" do
    get intranet_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_intranet_veiculo_url
    assert_response :success
  end

  test "should create intranet_veiculo" do
    assert_difference("Intranet::Veiculo.count") do
      post intranet_veiculos_url, params: { intranet_veiculo: { ano: @intranet_veiculo.ano, modelo: @intranet_veiculo.modelo } }
    end

    assert_redirected_to intranet_veiculo_url(Intranet::Veiculo.last)
  end

  test "should show intranet_veiculo" do
    get intranet_veiculo_url(@intranet_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_intranet_veiculo_url(@intranet_veiculo)
    assert_response :success
  end

  test "should update intranet_veiculo" do
    patch intranet_veiculo_url(@intranet_veiculo), params: { intranet_veiculo: { ano: @intranet_veiculo.ano, modelo: @intranet_veiculo.modelo } }
    assert_redirected_to intranet_veiculo_url(@intranet_veiculo)
  end

  test "should destroy intranet_veiculo" do
    assert_difference("Intranet::Veiculo.count", -1) do
      delete intranet_veiculo_url(@intranet_veiculo)
    end

    assert_redirected_to intranet_veiculos_url
  end
end
