class AddPlayerOneToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1_key, :string, default: nil
  end
end
