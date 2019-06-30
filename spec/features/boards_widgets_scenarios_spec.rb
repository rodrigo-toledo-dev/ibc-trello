require "rails_helper"

RSpec.feature "Boards Widgets Scenarios", :type => :feature do
  before do
    create(:board, name: 'Atividades extras RTOLEDO')
    create_list(:board, 2)
    create_list(:board, 2, :with_image)
    visit root_path
  end

  describe "User see boards widgets in the screen" do
    scenario "without filter" do
      expect(page).to have_selector('h6.card-title', count: 5)
      expect(page).to have_selector("img[src='http://placehold.it/500x325']", count: 3)
      expect(page).to have_text('5 Quadro(s) encontrado(s)')
    end

    scenario "with filter" do
      fill_in "Procurando um quadro?...",	with: "Extras RT"
      click_on 'Buscar'
      expect(page).to have_selector('h6.card-title', count: 1)
      expect(page).to have_selector("img[src='http://placehold.it/500x325']", count: 1)
      expect(page).to have_text('1 Quadro(s) encontrado(s)')
    end
  end
end
