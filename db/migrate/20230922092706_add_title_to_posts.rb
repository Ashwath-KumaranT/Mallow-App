class AddTitleToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :post_title, :string
  end
end
