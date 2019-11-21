class AddStartIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :start
  end
end
