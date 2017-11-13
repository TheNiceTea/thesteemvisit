class AddSteemFieldToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :steem, :float, default: 0.0
  end
end
