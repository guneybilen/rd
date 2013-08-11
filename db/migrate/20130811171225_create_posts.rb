class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content, :limit => 5000
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
