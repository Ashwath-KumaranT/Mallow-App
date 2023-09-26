class ChangeUserColumnInTopicsNotNull < ActiveRecord::Migration[7.0]
  def up
    change_column :topics, :user_id, :integer, null: false
  end

  def down
    change_column :topics, :user_id, :integer, null: true
  end
end