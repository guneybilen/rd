class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id, :null => false
      t.integer :user_id, :null => false
      t.text :comment
      t.integer :success, :default => 0
      t.integer :failure, :default => 0

      t.timestamps
    end

    add_index :comments, :post_id
  end
end
