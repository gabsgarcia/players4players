class CreateGamesSessionLists < ActiveRecord::Migration[6.0]
  def change
    create_table :games_session_lists do |t|
      t.boolean :subscribe, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
