class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      # the following are fields that we want to have available in our database
      # think of it just like 3 columns in an Excel sheet
      t.string :name
      t.text :description
      t.string :address
      t.timestamps
    end
  end
end