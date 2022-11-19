require_relative "env"

# include Generators

def generate_all
  load_config
  puts "generating code blocks..."
  unless ENV["GENERATE"] == "0"
    output = generate_app
    route_prompts = output.f :route_prompts
    # route_prompt = route_prompts.first
    route_prompts.each_with_index do |route_prompt, idx|
      generate_route route_prompt: route_prompt, idx: idx
      # exit
    end
  end
  # # generate_env
  # puts "performing test..."
  # test_app_and_env
  # generate_models
end

def concat_prompt(prompt:, few_shots_text:)
  prompt = prompt.strip
  "#{few_shots_text} #{prompt}\n# IMPLEMENTATION\n"
end

# this generates 1 prompt - at this stage 1 code block = 1 file
def generate_code_block(area:)
  prompt_template_name = :"prompt_#{area}"
  app_name  = :twitter_clone
  config    = STATE.f :config
  app       = config.f app_name
  prompt    = app.f prompt_template_name
  # prompt  = app.f :prompt_environment
  few_shots_text = load_few_shots_text name: prompt_template_name
  input   = concat_prompt prompt: prompt, few_shots_text: few_shots_text
  # print_debug prompt: input
  output = GPT3Prompt.generate input: input
  # print_output output: output
  template_filepath = TEMPLATE_PATHS.f prompt_template_name
  save_output filename: template_filepath, output: output

  route_prompts = []
  output.split("\n").each do |out|
    out.sub! /^-\s+roda\s+route\s+/, ''
    route_prompts << out
  end
  {
    route_prompts: route_prompts
  }
end

def generate_code_block_route(route_prompt:, idx:)
  # prompt  = app.f :prompt_environment
  few_shots_text = load_few_shots_text name: :prompt_route
  input   = concat_prompt prompt: route_prompt, few_shots_text: few_shots_text
  # print_debug prompt: input
  output = GPT3Prompt.generate input: input
  # print_output output: output
  template_filepath = TEMPLATE_PATHS.f :prompt_route
  save_output filename: template_filepath, output: output
end

def print_output(output:)
  puts "-"*100
  puts "OUTPUT"
  puts "-"*100
  puts output
  puts "-"*100
end


# TODO: change the few shots approach to a more meaty checkpoint based with no or minimal few shots text
# ---
# aka load prompt few shot text templates
def load_few_shots_text(name:)
  text = File.read "./templates/#{name}.md"
  text.sub! /<PROMPT>/, ''
  text.strip!
  text
end

def print_debug(prompt:)
  puts "-"*100
  puts "PROMPT"
  puts "-"*100
  puts prompt
  puts "-"*100
end

def save_output(filename:, output:)
  puts `mkdir -p "./generated_apps/01"`
  File.open("./generated_apps/01/#{filename}", "w") do |file|
    file.write output
  end
  puts "file written - #{filename}"
end

def generate_app
  generate_code_block area: :app
end

def generate_route(route_prompt:, idx:)
  generate_code_block_route route_prompt: route_prompt, idx: idx
end

def generate_env
  generate_code_block area: :environment
end

def generate_models
  # TODO: ...
  puts "exiting..."
  exit
end

module Testing
  def test_app_run_app
    test_app_run_app_run_thread
    test_app_run_app_test
  end

  def test_app_run_app_test
    url = "/weather"
    out = run_cmd "curl http://localhost:3000#{url}"
    puts "OUTPUT: '#{out}' == OK"
  end

  def test_app_run_app_run_thread
    Thread.new do
      run_cmd "cd ./test_app && BUNDLE_GEMFILE=./Gemfile bundle exec rackup -p 3000"
    end
    sleep 3
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
