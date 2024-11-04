class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :spotify_album_id
      t.string :title
      t.string :artist

      t.timestamps
    end
  end
end
