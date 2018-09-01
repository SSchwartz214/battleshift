class AddPlayerTneToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_2_key, :string, default: nil
  end
end
