class AddIsConnectedAtSpotifyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_connected_to_spotify, :boolean, default: false
  end
end
