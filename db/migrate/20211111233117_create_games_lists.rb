class CreateGamesLists < ActiveRecord::Migration[6.0]
  def change
    create_table :games_lists do |t|
      t.string :name
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
