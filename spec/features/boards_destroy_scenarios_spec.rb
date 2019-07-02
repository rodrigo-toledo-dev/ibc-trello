require "rails_helper"

RSpec.describe BoardsController, :type => :controller do
  describe "User destroy boards" do

    context "with success" do
      before do
        @board = create(:board, name: 'Atividades extras RTOLEDO')
      end
      it "destroy the board" do
        expect do
          delete :destroy, params: {id: @board}
        end.to change(Board, :count).by(-1)
      end
    end
  end

end
