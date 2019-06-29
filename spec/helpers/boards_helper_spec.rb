require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BoardsHelper. For example:
#
# describe BoardsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BoardsHelper, type: :helper do

  describe "board front image situations" do
    let!(:simple_board) { create(:board) }
    let!(:full_board) { create(:board, :with_image) }
    it "should return default image url" do
      expect(board_front_image_url(simple_board)).to eq('http://placehold.it/500x325')
    end

    it "should not return default image url" do
      expect(board_front_image_url(full_board)).not_to eq('http://placehold.it/500x325')
    end

  end

end
