
module Repo

  # RepositoryConfiguration contains operations related to the configuration
  # of Repository class instances.
  # 
	class RepositoryConfiguration
	  
	  attr_accessor :path, :properties
	  
	  # Initializes this repository configuration with the properties defined
	  # in the default repository YAML file.
	  #
	  def initialize
	    filename = File.join(File.dirname(__FILE__), 'repository.yml')
	    config = YAML::load(IO.read(filename))
	    @properties = config
	    load
	  end
	  
	  # Loads the properties for this repository configuration.
	  #
	  def load
	    @path = @properties['path']
	  end
	  
	  # Reloads the properties for this repository configuration based on the
	  # specified repository configuration file.
	  #
	  def reload(configuration_filename)
	    filename = File.join(File.dirname(__FILE__), configuration_filename)
	    config = YAML::load(IO.read(filename))
	    @properties = config
	    load
	  end
	  
	  def to_s
	    inspect
	  end
	  
	  def inspect
	    @properties.each do |k, v|
	      puts "property: #{}, value: #{v}"
	    end
	  end
	end
end