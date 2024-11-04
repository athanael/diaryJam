class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.references :album, null: false, foreign_key: true
      t.string :spotify_track_id
      t.string :title

      t.timestamps
    end
  end
end
