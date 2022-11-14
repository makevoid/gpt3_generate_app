# DESCRIPTION
# minimalistic env file
# IMPLEMENTATION
require "bundler"
Bundler.require :default

PATH = File.expand_path "../", __FILE__
# DESCRIPTION
# env file that initializes redis
# IMPLEMENTATION
require "bundler"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

R = Redis.new
# DESCRIPTION
# env file that autoloads lib
# IMPLEMENTATION
require "bundler"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

module AutoloadDirs
  def autoload_dir(directory:)
    DirAutoloader.new(dir: dir).autoload
  end
end

class DirAutoloader
  attr_reader :directory

  def initializer(dir:)
    @directory = dir
  end

  def autoload
    require_dir
  end

  private

  def require_dir
    files = get_files
    require_files files: files
  end

  def require_files(files:)
    files.each do |file|
      require_file file: file
    end
  end

  def require_file(file:)
    require "#{PATH}/#{file}"
  end

  def get_files
    Dir.glob "#{directory}/*.rb"
  end

end

extend AutoloadDirs
autoload_dir directory: "lib"
# DESCRIPTION
# env file that loads config including `:docker`
# IMPLEMENTATION
require "bundler"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

def load_config
  YAML.load_file "#{PATH}/config/config.yml"
end

CONFIG = load_config

DOCKER = CONFIG.fetch :docker
docker = DOCKER
raise "ConfigNotSetError - Docker" if !docker || docker.empty?
# DESCRIPTION
# env file that has a timer method
# IMPLEMENTATION
require "bundler"
Bundler.require :default

TIMER = Time.new

module TimeElapsed
  def time_elapsed
    puts "timer: #{(TIMER - Time.now).round 2}s"
  end
end

include TimeElapsed

time_elapsed
# DESCRIPTION
# env file that initializes redis and has configs - redis_host, infura_project_id, nft_contract_ids
# IMPLEMENTATION
require "bundler"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

R = Redis.new

def load_config
  YAML.load_file "#{PATH}/config/config.yml"
end

CONFIG = load_config

DOCKER = CONFIG.fetch :docker
docker = DOCKER
raise "ConfigNotSetError - Docker" if !docker || docker.empty?

REDIS_HOST = CONFIG.fetch :redis_host
raise "ConfigNotSetError - Redis Host" if !REDIS_HOST || REDIS_HOST.empty?

INFURA_PROJECT_ID = CONFIG.fetch :infura_project_id
raise "ConfigNotSetError - Infura Project ID" if !INFURA_PROJECT_ID || INFURA_PROJECT_ID.empty?

NFT_CONTRACT_IDS = CONFIG.fetch :nft_contract_ids
raise "ConfigNotSetError - NFT Contract IDs" if !NFT_CONTRACT_IDS || NFT_CONTRACT_IDS.empty?
# DESCRIPTION
# env file that <PROMPT>
