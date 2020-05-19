require './lib/database_connection'
p "in database con setup"

if ENV['ENVIRONMENT'] == 'test'
  p "in database con setup - test"
  DatabaseConnection.setup('spaced_out_test')
else
  p "in database con setup- not test"
  DatabaseConnection.setup('spaced_out')
end
