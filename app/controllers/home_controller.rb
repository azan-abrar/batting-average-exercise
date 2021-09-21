class HomeController < ApplicationController
  def index
    @battings = BattingAverage.order(id: :desc)
    @battings = @battings.search_by_year(params[:year]) if params[:year].present?
    @battings = @battings.search_by_team_name(params[:team_name]) if params[:team_name].present?
    respond_to do |format|
      format.js
      format.html
    end
  end
end
