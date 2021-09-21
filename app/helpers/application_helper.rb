module ApplicationHelper

  def calculate_player_ranking(prev_player_ranking, prev_player_average, current_player_ranking, current_player_average)
    (prev_player_average == current_player_average ? prev_player_ranking : current_player_ranking)
  end

end
