class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.string :spotify_id
      t.integer :duration_ms
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
