require 'pg'
require 'bcrypt'

def setup_test_database
  connection = PG.connect(dbname: 'spaced_out_test')

  # Clear the bookmarks table
  connection.exec("TRUNCATE bookings, users;")
  connection.exec("INSERT INTO users (id, username, name, email, password) VALUES (1, 'Joe1984', 'Joe Bloggs', 'joebloggs@hotmail.com', '#{BCrypt::Password.create('12345')}');")
end
