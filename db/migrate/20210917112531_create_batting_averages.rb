class CreateBattingAverages < ActiveRecord::Migration[5.2]
  def change
    create_table :batting_averages do |t|
      t.string  :player_id
      t.string  :team_name
      t.string  :year_id
      t.decimal :hits
      t.decimal :at_bats
      t.integer :stint
      t.decimal :average_batting

      t.timestamps
    end
  end
end
