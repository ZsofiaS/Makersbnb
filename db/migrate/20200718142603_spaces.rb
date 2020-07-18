class Spaces < ActiveRecord::Migration[6.0]
  def change
    # CREATE TABLE spaces(id SERIAL PRIMARY KEY, name VARCHAR(300), description VARCHAR(2000),
    # location VARCHAR(100), available_to DATE, available_from DATE, price INT );
    #
    # ALTER TABLE spaces
    # ADD COLUMN user_id INT;

    t.string :name
    t.string :description
    t.string :location
    t.date :available_to
    t.date :available_from
    t.integer :price
    t.integer: :user_id
  end
end
