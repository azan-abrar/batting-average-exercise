module BattingAverageConcern
  extend ActiveSupport::Concern

  included do
    require 'csv'

    class << self
      def parse_csv(file)
        CSV.foreach(file.path, :headers => true, :converters => :all, :header_converters => lambda { |h| process_headers(h) }) do |row|
          find_or_create_by(player_id: row.dig('player_id')) do |ba|
            team = Team.find_by(team_id: row.dig('team_id'))
            next if team.blank?

            ba.team_name = team&.name
            ba.year_id   = row.dig('year_id')
            ba.hits      = row.dig('hits').to_d
            ba.at_bats   = row.dig('at_bats').to_d
            ba.average_batting = calculate_average(row)
          end
        end
      end

      def process_headers(header_key)
        header_key.downcase.gsub(' ', '_')
      end

      def calculate_average(row)
        (row.dig('hits')/row.dig('at_bats')).to_d
      end

      def search_by_year(year)
        where('year_id LIKE ?', "%#{year}%")
      end

      def search_by_team_name(name)
        where('lower(team_name) LIKE ?', "%#{name.downcase}%")
      end
    end

  end
end
