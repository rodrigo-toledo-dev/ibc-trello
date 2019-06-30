require "rails_helper"

RSpec.feature "Boards Save Scenarios", :type => :feature do
  describe "User creating boards" do
    before do
      visit root_path
    end
    scenario "with error" do
      click_on "Salvar"
      expect(page).to have_text('Erro ao criar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco')
    end

    describe "with success" do
      scenario "just with name" do
        fill_in "board_name",	with: "A Fazer"
        click_on "Salvar"
        expect(page).to have_text('Quadro criado com sucesso')
        expect(page).to have_text('A Fazer')
      end

      scenario "with all attributes" do
        fill_in "board_name",	with: "A Fazer com imagem"
        attach_file("board_front_image",	Rails.root.join('spec', 'support', 'assets', 'test-image.png').to_s)
        click_on "Salvar"
        expect(page).to have_text('Quadro criado com sucesso')
        expect(page).to have_text('com imagem')
      end
    end
  end

  describe "User editing boards" do
    before do
      @board = create(:board, name: 'Atividades extras RTOLEDO')
      visit root_path(id: @board)
    end
    scenario "with error" do
      fill_in "board_name",	with: ""
      click_on "Salvar"
      expect(page).to have_text('Erro ao atualizar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco')
    end

    describe "with success" do
      scenario "just with name" do
        fill_in "board_name",	with: "Atividades normais RTOLEDO"
        click_on "Salvar"
        expect(page).to have_text('Quadro atualizado com sucesso')
        expect(page).to have_text('Atividades normais RTOLEDO')
      end

      scenario "with all attributes" do
        fill_in "board_name",	with: "Atividades normais com imagem RTOLEDO"
        attach_file("board_front_image",	Rails.root.join('spec', 'support', 'assets', 'test-image.png').to_s)
        click_on "Salvar"
        expect(page).to have_text('Quadro atualizado com sucesso')
        expect(page).to have_text('com imagem RTOLEDO')
      end
    end
  end

end
