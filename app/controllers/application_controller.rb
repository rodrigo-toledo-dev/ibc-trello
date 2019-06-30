class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @q = Board.order('created_at desc').ransack(params[:q])
  end
end
