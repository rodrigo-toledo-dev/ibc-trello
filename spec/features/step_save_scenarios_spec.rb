require "rails_helper"

RSpec.feature "Steps Save and Display Scenarios", :type => :feature do
  describe "User creating steps" do
    before do
      @board = create(:board)
      visit board_path(@board)
    end
    scenario "with error" do
      find('#save-new-step').click
      expect(page).to have_text('Erro ao criar esta Etapa, verifique os alertas: Nome da Etapa não pode ficar em branco')
    end

    describe "with success" do
      scenario "with attributes" do
        fill_in placeholder: "descreva a etapa",	with: "Café da manhã"
        find('#save-new-step').click
        expect(page).to have_text('Etapa criada com sucesso')
        expect(Step.find_by_name('Café da manhã')).not_to be_nil
      end
    end
  end

  # describe "User editing boards" do
  #   before do
  #     @board = create(:board, name: 'Atividades extras RTOLEDO')
  #     visit board_path(id: @board)
  #   end
  #   scenario "with error" do
  #     fill_in "board_name",	with: ""
  #     find('#save-board').click
  #     expect(page).to have_text('Erro ao atualizar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco')
  #   end

  #   describe "with success" do
  #     scenario "just with name" do
  #       fill_in "board_name",	with: "Atividades normais RTOLEDO"
  #       find('#save-board').click
  #       expect(page).to have_text('Quadro atualizado com sucesso')
  #       expect(page).to have_text('Atividades normais RTOLEDO')
  #     end

  #     scenario "with all attributes" do
  #       fill_in "board_name",	with: "Atividades normais com imagem RTOLEDO"
  #       attach_file("board_front_image",	Rails.root.join('spec', 'support', 'assets', 'test-image.png').to_s)
  #       find('#save-board').click
  #       expect(page).to have_text('Quadro atualizado com sucesso')
  #       expect(page).to have_text('com imagem RTOLEDO')
  #     end
  #   end
  # end

end
