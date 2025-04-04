class AddTimestampsToRatings < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :ratings, null: true

    # Backfill existing records with a default timestamp
    now = DateTime.current
    Rating.update_all(created_at: now, updated_at: now)

    # Make the columns not nullable
    change_column_null :ratings, :created_at, false
    change_column_null :ratings, :updated_at, false
  end
end
