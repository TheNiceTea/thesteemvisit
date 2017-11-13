class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.integer :clicks
      t.string :ref
      t.integer :post_id

      t.timestamps
    end
  end
end
