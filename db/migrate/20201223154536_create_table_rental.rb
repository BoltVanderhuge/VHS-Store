class CreateTableRental < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.boolean :current
      t.integer :vhs_id
      t.integer :client_id
      t.timestamps
    end
  end
end

