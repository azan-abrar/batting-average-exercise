module BattingRecordConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :team
    belongs_to :player_record
    validates :player_record_id, uniqueness: { scope: :team_id }

    class << self
      def generate_records(team_id, player_record_id)
        find_or_create_by(team_id: team_id, player_record_id: player_record_id)
      end
    end
  end
end
