class ChangeUserColumnInCommentsNotNull < ActiveRecord::Migration[6.0]
  def up
    change_column :comments, :user_id, :integer, null: false
  end

  def down
    change_column :comments, :user_id, :integer, null: true
  end
  end