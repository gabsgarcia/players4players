class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :controller
      t.string :summary
      t.string :category
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
