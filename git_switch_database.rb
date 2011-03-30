# check if the development database for this branch exists and create it if not

database_configuration = ActiveRecord::Base.configurations["development"]
database_name = database_configuration["database"]

ActiveRecord::Base.establish_connection(database_configuration)
begin
  ActiveRecord::Base.connection
  puts "Switched to database '#{database_name}'"
rescue
  # create the database
  puts "Creating the #{database_name} database"
  %x[rake db:setup]
end

# now we know we have a database, setup the test database

puts "Preparing the test database"
%x[rake db:test:prepare]
