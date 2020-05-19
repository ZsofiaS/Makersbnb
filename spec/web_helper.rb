def set_up_user_test_database
  connection = PG.connect(dbname: 'spaced_out_test')
  connection.exec('TRUNCATE users;')
end