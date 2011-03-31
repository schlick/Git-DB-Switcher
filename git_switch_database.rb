# check if the development database for this branch exists and create it if not

require 'yaml'
require 'erb'

db_settings = YAML.load(ERB.new(File.read("config/database.yml")).result)["development"]
db_name = db_settings["database"]
db_host = "localhost"
db_user = db_settings["username"]
db_pass = db_settings["password"]

require 'dbi'
require 'dbd/mysql'

begin
  dbh = DBI.connect("DBI:Mysql:#{db_name}:#{db_host}", db_user, db_pass)
  puts "Switched to database '#{db_name}'"
rescue DBI::DatabaseError => e
  puts "Database #{db_name} does not exist."
  # puts "Creating the #{db_name} database"
  # %x[rake db:setup]
end

# now we know we have a database, setup the test database

# puts "Preparing the test database"
# {}%x[rake db:test:prepare]
