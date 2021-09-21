class CreatePlayerRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :player_records do |t|
      t.string  :player_id
      t.decimal :hits
      t.decimal :at_bats
      t.string  :year_id
      t.timestamps
    end
  end
end
