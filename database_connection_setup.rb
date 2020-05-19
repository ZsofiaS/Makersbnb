require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('spced_out_test')
else
  DatabaseConnection.setup('spaced_out')
end
