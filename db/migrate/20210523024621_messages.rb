class Messages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, id: false do |t|
      t.integer :user_id
      t.integer :friend_user_id
      t.text :message
      t.timestamps
    end
  end
end
