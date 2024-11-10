class AddDetailsToTracks < ActiveRecord::Migration[7.1]
  def change
    add_column :tracks, :preview_url, :string
    add_column :tracks, :image_url, :string
  end
end
