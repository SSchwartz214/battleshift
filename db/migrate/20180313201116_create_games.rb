class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.text :player_1_board
      t.text :player_2_board
      t.string :winner
      t.integer :player_1_turns
      t.integer :player_2_turns
      t.string :current_turn, default: "start"
      t.timestamps
    end
  end
end
