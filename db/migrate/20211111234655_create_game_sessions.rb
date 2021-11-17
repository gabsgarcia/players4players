class CreateGameSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :game_sessions do |t|
      t.string :description
      t.date :date
      t.time :time
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
