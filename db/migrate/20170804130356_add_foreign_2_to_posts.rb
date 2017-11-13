class AddForeign2ToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :statistic, foreign_key: true
  end
end
