class Bookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      #id SERIAL PRIMARY KEY, date DATE, space_id INTEGER, user_id INTEGER, status VARCHAR(20));
      t.date :date
      t.integer :space_id
      t.integer :user_id
      t.string :status
    end
  end
end
