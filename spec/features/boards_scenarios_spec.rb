require "rails_helper"

RSpec.feature "Boards Scenarios", :type => :feature do
  before do
    create(:board, name: 'Atividades extras RTOLEDO')
    create_list(:board, 5)
    create_list(:board, 6, :with_image)
    visit root_path
  end

  describe "User see boards widgets in the screen" do
    scenario "without filter" do
      expect(page).to have_selector('h6.card-title', count: 12)
      expect(page).to have_selector("img[src='http://placehold.it/500x325']", count: 6)
    end

    scenario "with filter" do
      fill_in "Procurando um quadro?...",	with: "Extras RT"
      click_on 'Buscar'
      expect(page).to have_selector('h6.card-title', count: 1)
      expect(page).to have_selector("img[src='http://placehold.it/500x325']", count: 1)
    end
  end

  describe "User creating boards" do
    scenario "with error" do
      click_on "Criar"
      expect(page).to have_text('Erro ao criar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco')
    end

    describe "with success" do
      scenario "just with name" do
        fill_in "board_name",	with: "A Fazer"
        click_on "Criar"
        expect(page).to have_text('Quadro criado com sucesso')
        expect(page).to have_text('A Fazer')
      end

      scenario "with all attributes" do
        fill_in "board_name",	with: "A Fazer com imagem"
        attach_file("board_front_image",	Rails.root.join('spec', 'support', 'assets', 'test-image.png').to_s)
        click_on "Criar"
        expect(page).to have_text('Quadro criado com sucesso')
        expect(page).to have_text('A Fazer com imagem')
      end
    end
  end
end
