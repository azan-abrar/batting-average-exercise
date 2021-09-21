module TeamConcern
  extend ActiveSupport::Concern

  included do
    require 'csv'

    extend FriendlyId
    friendly_id :team_id, use: :slugged

    def should_generate_new_friendly_id?
      team_id_changed?
    end

    class << self
      def parse_csv(file)
        CSV.foreach(file.path, :headers => true, :converters => :all, :header_converters => lambda { |h| process_headers(h) }) do |row|
          find_or_create_by(name: row.dig('name')) do |team|
            team.team_id = row&.dig('team_id')
          end
        end
      end

      def process_headers(header_key)
        header_key.downcase.gsub(' ', '_').gsub("team_name","name")
      end
    end
  end
end
