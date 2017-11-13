class AddSteemFieldsToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :steem, :float, default: 0.0
  	add_column :posts, :payout, :float, default: 0.0
  end
end
