class AddSpotifyInfosToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :spotify_url, :string
    add_column :users, :spotify_token, :string
    add_column :users, :spotify_refresh_token, :string
    add_column :users, :token_expires_at, :datetime
  end
end
