class Users < ActiveRecord::Migration[6.0]
  def change
    #CREATE TABLE users(id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(200), password VARCHAR(150), username VARCHAR(50));
    t.string :name
    t.string :email
    t.string :password
    t.string :username
  end
end
