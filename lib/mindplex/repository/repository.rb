require 'find'
require 'pathname'

module Repo
  
  # Repository contains operations for saving and viewing stored data.
  # For example, this repository can be used to persist xml documents
  # in the file system providing an abstraction that hides the details
  # of actual storage location and directory structure info.  Data stored
  # in the repository can be fetched by simple listing the repository
  # with a specified target directory name.  
  #
  # The convention used for storing documents is that the specified directory
  # name is a logical name that maps to a specific application or application 
  # type.  For example, to store audit trail xml documents for a robot 
  # framework, the directory name specified in the save operation of this
  # repository could be "robot".  The repository would then store the given
  # document under a child directory labeled with the current date under 
  # the parent directory robot i.g., "robot/yyyy-mm-dd/unix_time_robot.xml".
  #
  # The file extension used to store specified documents is based on a given
  # data type or defaults to .xml.  Files are labeled with the following 
  # format: unixtime_directory_name.type, i.e., 1281985821_robot.xml 
  #
  class Repository
    
    # Default filename seperator.
    # 
    SEPARATOR = '_'
    
    # Default extension sepertor
    # 
    EXTENSION = '.'
    
    attr_accessor :configuration
    
    # Initializes this repository with a default repository configuration.
    #
    def initialize
      @configuration = RepositoryConfiguration.new
    end
    
    # The absolute directory path where this repository has been configured to
    # store data.
    #
    def path
      @configuration.path
    end

    # List's all the directories that exist in this repository.
    #  
    def list_directories
      Dir.chdir(path)
      Dir.foreach(EXTENSION) do |element|
        next if element == "." or element == ".."
        yield element
      end
    end

    # List's all the files under the specified directory.
    #  
    def list_directory(directory)
      return if directory == nil
      
      repo = File.join(path, directory)
      return unless File.directory?(repo)    
      
      Dir.chdir(repo)
      Dir.foreach(EXTENSION) do |element|
        next if element == "." or element == ".."
        yield element
      end
    end

    # List's all the files in this repository.
    #
    def list_files
      Find.find(path) do |element| yield element end
    end
    
    # Create's a new direcotry in this repository based on the specified directory
    # name.  If the specified directory already exists, then no action is taken.
    #    
    def create_directory(directory)
      Dir.chdir(path)
      Dir.mkdir(directory) unless File.directory?(directory)
    end

    # Save's the specified data in the given directory as the specified data type.
    # If no data type is provided, the default data type xml will be used.  If the
    # specified directory does not exists, it will be created. If the specified 
    # file exists then it will be overwritten.
    #    
    def save(directory, data, type = 'xml')
      return if directory == nil || data == nil
      
      begin
        # verify target directory
        Dir.chdir(path)
        Dir.mkdir(directory) unless File.directory?(directory)
        
        repo = File.join(path, directory)
        child = day_to_directory
        
        # verify actual target directory (day)
        Dir.chdir(repo)
        Dir.mkdir(child) unless File.directory?(child)
        repo = File.join(repo, child)
        
        # create absolute filename.
        filename = unixtime + SEPARATOR + directory + EXTENSION + type
        target = File.join(repo, filename)
        
        # create the file
        open(target, 'w') { |file| file << data }
        
      rescue Exception => error
        puts "error: #{error.message}" 
      end
    end

    # Check's if the specified directory exists in this repository.
    #  
    def exists?(directory)
      Dir.chdir(path)
      File.directory?(directory)
    end
    
    # Check's if the specified file exists in the given directory.
    #  
    def file_exists?(directory, filename)
      return false if !exists? directory
      
      target = File.join(path, directory)
      Dir.chdir(target)
      File.exist?(filename)
    end
    
    # Find's the directory in which the specified file exists in.
    #  
    def find_location(filename)
      Find.find(path) do |element| 
        if element.include? filename
          candidate = Pathname.new(element)
          yield candidate.dirname.to_s
        end 
      end
    end
       
    # Find's the specified file in this repository. A handle to the file is
    # returned if the file exists, otherwise nil.
    #  
    def find(filename)
      find_location filename do |file|
        return File.new file
      end
    end
    
    #
    #
    #  
    def inspect
      list_files do |element|
        puts element
      end
    end

    #
    #
    #  
    def to_s
      "path: #{path}"
    end

    private
    
    # String representation of the current unix timestamp.
    #
    def unixtime
      Time.now.to_i.to_s
    end
    
    # Create's a directory name based on the current date in the following
    # format: '%Y-%m-%d'
    #
    def day_to_directory
      Date.strptime(DateTime.now.to_s, '%Y-%m-%d').to_s
    end
    
  end
end