ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))

ActiveRecord::Base.establish_connection(
:adapter => "mysql",
:host     => "localhost",
:username => "myuser",
:password => "mypassword",
:database => "mydatabase"
)