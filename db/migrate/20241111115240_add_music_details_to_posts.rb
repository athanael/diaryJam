class AddMusicDetailsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :cover_url, :string
    add_column :posts, :preview_url, :string
    add_column :posts, :track_title, :string
    add_column :posts, :artist_name, :string
    add_column :posts, :review, :text
  end
end
