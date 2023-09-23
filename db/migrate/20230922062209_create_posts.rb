class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|

      t.string :post_title
      t.text :post_content
      t.references :topic, null: false, foreign_key: true
      t.timestamps
    end
  end
end