module PlayerRecordConcern
  extend ActiveSupport::Concern

  included do
    has_many  :batting_records
    validates :player_id, :year_id, presence: true
    validates :player_id, uniqueness: { scope: :year_id }

    require 'csv'

    class << self
      def parse_csv(file)
        CSV.foreach(file.path, :headers => true, :converters => :all, :header_converters => lambda { |h| process_headers(h) }) do |row|
          player_record = find_or_create_by(player_id: row.dig('player_id')&.strip, year_id: row.dig('year_id')) do |pr|
            pr.hits      = row.dig('hits').to_d
            pr.at_bats   = row.dig('at_bats').to_d
          end

          stints_count = row.dig('stint')&.to_i
          teams = row.dig('team_id')&.split(",")&.collect(&:strip)
          stints_count.times do |stint|
            team = Team.find_by(team_id: teams[stint])
            next if team.blank?

            BattingRecord.generate_records(team&.id, player_record&.id)
          end
        end
      end

      def process_headers(header_key)
        header_key.downcase.gsub(' ', '_')
      end

      def search_by_year(year)
        where('year_id LIKE ?', "%#{year}%")
      end

      def search_by_team_name(name)
        teams = Team.where('lower(name) LIKE ?', "%#{name.downcase}%")
        player_record_ids = teams&.map(&:batting_records)&.flatten&.collect(&:player_record_id)
        where(id: player_record_ids)
      end
    end

    def teams
      team_ids = self&.batting_records&.collect(&:team_id)
      team_ids.blank? ? "N/A" : Team.where(id: team_ids)&.map(&:name)&.join(", ")
    end

    def batting_average
      (self.hits / self.at_bats).to_d
    end
  end
end
