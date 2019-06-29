require "rails_helper"

RSpec.feature "Boards Scenarios", :type => :feature do
  before do
    create_list(:board, 6)
    create_list(:board, 6, :with_image)
  end

  scenario "User see boards widgets in the screen" do
    visit root_path
    expect(page).to have_selector('h6.card-title', count: 12)
    expect(page).to have_selector("img[src='http://placehold.it/500x325']", count: 6)
  end

  describe "User creating boards" do
    before do
      visit root_path
    end
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
