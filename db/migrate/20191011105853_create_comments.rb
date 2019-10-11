class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.string :rating
      t.integer :user_id
      t.integer :place_id
      t.timestamps
    end

    add_index :comments, [:user_id, :place_id]
    add_index :comments, :place_id
  end
end 

#we added a field for each of the fields we want to keep track of (the message
#and the rating), and added a field that will point to the id of different
#tables in our database we want to connect the comment to (in this case
#place_id and user_id).