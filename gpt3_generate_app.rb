require_relative "env"

# include Generators

def generate_all
  load_config
  puts "generating code blocks..."
  generate_app
  generate_env
  puts "performing test..."
  test_app_and_env
  generate_models
end


def concat_prompt
  prompt = prompt.strip
  "#{prompt}\n# IMPLEMENTATION\n"
end

# this generates 1 prompt - at this stage 1 code block = 1 file
def generate_code_block(area:)
  input = concat_prompt STATE.f(:config).f(area)
  out = GPT3Prompt.generate input: input
  save_output filename: STATE.f(:config).f(:filename), output: out
end

def save_output(filename:, output:)
  puts `mkdir -p "./generated_apps/01"`
  File.open("./generated_apps/01/#{filename}") do |file|
    file.write output
  end
  puts "file written - #{filename}"
end

def generate_app
  generate_code_block area: :app
end

def generate_env
  generate_code_block area: :environment
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

# ---

def main
  generate_all
end

main
