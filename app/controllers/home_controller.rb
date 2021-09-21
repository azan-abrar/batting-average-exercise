class HomeController < ApplicationController
  def index
    @player_records = PlayerRecord.limit(20)
    @player_records = @player_records.search_by_year(params[:year]) if params[:year].present?
    @player_records = @player_records.search_by_team_name(params[:team_name]) if params[:team_name].present?
    @player_records = @player_records.all.sort_by(&:batting_average).reverse!
    respond_to do |format|
      format.js
      format.html
    end
  end
end
