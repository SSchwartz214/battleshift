class AddIdentifierToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :identifier, :string, default: nil
  end
end
