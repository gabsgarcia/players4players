class CreateGamesControllers < ActiveRecord::Migration[6.0]
  def change
    create_table :games_controllers do |t|
      t.string :name
      t.string :type
      t.references :platform, null: false, foreign_key: true
      t.references :game_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
