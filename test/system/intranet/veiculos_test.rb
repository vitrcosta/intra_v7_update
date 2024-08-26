require "application_system_test_case"

class Intranet::VeiculosTest < ApplicationSystemTestCase
  setup do
    @intranet_veiculo = intranet_veiculos(:one)
  end

  test "visiting the index" do
    visit intranet_veiculos_url
    assert_selector "h1", text: "Veiculos"
  end

  test "should create veiculo" do
    visit intranet_veiculos_url
    click_on "New veiculo"

    fill_in "Ano", with: @intranet_veiculo.ano
    fill_in "Modelo", with: @intranet_veiculo.modelo
    click_on "Create Veiculo"

    assert_text "Veiculo was successfully created"
    click_on "Back"
  end

  test "should update Veiculo" do
    visit intranet_veiculo_url(@intranet_veiculo)
    click_on "Edit this veiculo", match: :first

    fill_in "Ano", with: @intranet_veiculo.ano
    fill_in "Modelo", with: @intranet_veiculo.modelo
    click_on "Update Veiculo"

    assert_text "Veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy Veiculo" do
    visit intranet_veiculo_url(@intranet_veiculo)
    click_on "Destroy this veiculo", match: :first

    assert_text "Veiculo was successfully destroyed"
  end
end
