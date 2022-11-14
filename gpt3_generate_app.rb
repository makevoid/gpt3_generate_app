require_relative 'env'

# include Generators

def main
  generate_all
end

def generate_all
  load_config
  generate_app
  generate_env
  puts "performing test..."
  test_app_and_env
  generate_models
end

def generate_app
  GPT3Prompt.generate input: CONFIG.f("app")
end

def generate_env
  GPT3Prompt.new
end

def generate_models
  exit
end

module Testing
  def test_app_run_app
    test_app_run_app_run_thread
    test_app_run_app_test
  end

  def test_app_run_app_test
    out = run_cmd "curl http://localhost:3000"
    puts "OUTPUT: '#{out}' == OK"
  end

  def test_app_run_app_run_thread
    Thread.new do
      run_cmd "bundle exec rackup"
    end
    sleep 4
  end

  private

  def run_cmd(cmd)
    out = `#{cmd}`
    puts out
    out
  end
end

include Testing

def test_app_and_env
  test_app_run_app
end

# TODO: extract

CONFIG = {}

module Config
  def load_config
    conf = YAML.load_file "./config.yml"
    CONFIG = conf
  end
end
