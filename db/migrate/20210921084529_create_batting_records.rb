class CreateBattingRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :batting_records do |t|
      t.belongs_to :team
      t.belongs_to :player_record

      t.timestamps
    end
  end
end
