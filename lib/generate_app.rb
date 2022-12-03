class GenerateApp

  include AppTesting

  def initialize
    # ...
  end

  def self.generate_all
    new.generate_all
  end

  def generate_all
    load_config
    prepare_generated_app_dir
    delete_generated_app

    unless ENV["GEN"] == "0"
      puts "generating code blocks..."
      app_output = generate_app
      raise "NoRoutePromptsFound - you cannot have an app without routes, the app generation step probably failed" if app_output.f(:route_prompts).empty?
      raise "NoModelsFound - you cannot have an app without a model, the app generation step probably failed" if app_output.f(:model_prompts).empty?
      raise "NoModelMethodsFound - you cannot have a model without methods, the app generation step probably failed" if app_output.f(:model_method_prompts).empty?
      generate_routes         app_output: app_output
      generate_models         app_output: app_output
      generate_model_methods  app_output: app_output
    else
      puts "regeneration skipped"
    end

    prepare_application
    # generate_migration
    # generate_models

    # # generate_env
    # puts "performing test..."
    test_app_and_env
  end

  def generate_routes(app_output:)
    route_prompts = app_output.f :route_prompts
    # route_prompt = route_prompts.first
    route_prompts.each_with_index do |route_prompt, idx|
      generate_route route_prompt: route_prompt, idx: idx
      # exit
    end
  end

  def generate_models(app_output:)
    model_prompts = app_output.f :model_prompts
    # model_prompts = model_prompts.first
    model_prompts.each_with_index do |model_prompt, idx|
      generate_model model_prompt: model_prompt, idx: idx
      # exit
    end
  end

  def generate_model_methods(app_output:)
    model_method_prompts = app_output.f :model_method_prompts
    # model_method_prompt = model_method_prompts.first
    model_method_prompts.each_with_index do |model_method_prompt, idx|
      generate_model_method model_method_prompt: model_method_prompt, idx: idx
      # exit
    end
  end

  def test_app_and_env
    test_app_run_app
  end

  def read_app_template
    path_tpl = "./test_app/app_template.rb"
    template = File.read path_tpl
    template
  end

  def write_app_file(routes:)
    path = "./generated_apps/01/app.rb"
    template = read_app_template
    contents = template.sub "<ROUTES>", routes
    File.open(path, "w") do |file|
      file.write contents
    end
  end

  def prepare_generated_app_dir
    puts `mkdir -p "./generated_apps/01"`
  end

  def delete_generated_app
    path = "./generated_apps/01/*"
    puts `rm -rf #{path}`
  end

  def add_spacing(route:)
    spacing = " "*4
    route = route.split("\n").map do |line|
      line = "#{spacing}#{line}"
    end
    route = route.join "\n"
    route
  end

  def prepare_application
    path = "./generated_apps/01"
    routes_files = Dir.glob "#{path}/route_*.rb"
    routes = ""
    routes_files.each do |route_file|
      route = File.read route_file
      route = add_spacing route: route
      routes << "#{route}\n\n"
    end
    routes
    write_app_file routes: routes
  end

  def concat_prompt(prompt:, few_shots_text:)
    prompt = prompt.strip
    "#{few_shots_text} #{prompt}\n# IMPLEMENTATION\n"
  end

  PROMPT_ROUTE_PREFIX = "write a ruby roda route"
  PROMPT_MODEL_PREFIX = "write a ruby model"
  PROMPT_MODEL_METHOD_PREFIX = "write a ruby model method"

  def concat_prompt_route(prompt:, few_shots_text:)
    prompt = prompt.strip
    prompt = "#{PROMPT_ROUTE_PREFIX} #{prompt}"
    "#{few_shots_text}\n#{prompt}\n# IMPLEMENTATION\n"
  end

  def concat_prompt_model(prompt:, few_shots_text:)
    prompt = prompt.strip
    prompt = "#{PROMPT_MODEL_PREFIX} #{prompt}"
    "#{few_shots_text}\n#{prompt}\n# IMPLEMENTATION\n"
  end

  def concat_prompt_model_method(prompt:, few_shots_text:)
    prompt = prompt.strip
    prompt = "#{PROMPT_MODEL_METHOD_PREFIX} #{prompt}"
    "#{few_shots_text}\n#{prompt}\n# IMPLEMENTATION\n"
  end

  # this generates 1 prompt - at this stage 1 code block = 1 file
  def generate_code_block_app(area:)
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
    model_prompts = []
    model_method_prompts = []
    output.split("\n").each do |out|
      route_regex = /^-\s+roda\s+route\s+/
      if out =~ route_regex
        out.sub! route_regex, ''
        route_prompts << out
      end
      model_regex = /^-\s+model\s[^m]+/
      if out =~ model_regex
        out.sub! /^-\s+model\s+/, ''
        model_prompts << out
      end
      model_method_regex = /^-\s+model\s+method\s+/
      if out =~ model_method_regex
        out.sub! model_method_regex, ''
        model_method_prompts << out
      end
    end
    {
      route_prompts:        route_prompts,
      model_prompts:        model_prompts,
      model_method_prompts: model_method_prompts,
    }
  end

  # TODO: refactor between code_block_route, model and model_method - DRY

  def generate_code_block_route(route_prompt:, idx:)
    # prompt  = app.f :prompt_environment
    few_shots_text = load_few_shots_text name: :prompt_route
    input   = concat_prompt_route prompt: route_prompt, few_shots_text: few_shots_text
    # print_debug prompt: input
    output = GPT3Prompt.generate input: input
    print_output output: output
    template_filepath = TEMPLATE_PATHS.f :prompt_route
    template_filepath = template_filepath % idx
    save_output filename: template_filepath, output: output
  end

  def generate_code_block_model(model_prompt:, idx:)
    # prompt  = app.f :prompt_environment
    few_shots_text = load_few_shots_text name: :prompt_model
    input   = concat_prompt_model prompt: model_prompt, few_shots_text: few_shots_text
    # print_debug prompt: input
    output = GPT3Prompt.generate input: input
    print_output output: output
    template_filepath = TEMPLATE_PATHS.f :prompt_model
    template_filepath = template_filepath % idx
    save_output filename: template_filepath, output: output
  end

  def generate_code_block_model_method(model_method_prompt:, idx:)
    # prompt  = app.f :prompt_environment
    few_shots_text = load_few_shots_text name: :prompt_model_method
    input   = concat_prompt_model_method prompt: model_method_prompt, few_shots_text: few_shots_text
    # print_debug prompt: input
    output = GPT3Prompt.generate input: input
    print_output output: output
    template_filepath = TEMPLATE_PATHS.f :prompt_model_method
    template_filepath = template_filepath % idx
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
    File.open("./generated_apps/01/#{filename}", "w") do |file|
      file.write output
    end
    puts "file written - #{filename}"
  end

  def generate_app
    generate_code_block_app area: :app
  end

  def generate_route(route_prompt:, idx:)
    generate_code_block_route route_prompt: route_prompt, idx: idx
  end

  def generate_model(model_prompt:, idx:)
    generate_code_block_model model_prompt: model_prompt, idx: idx
  end

  def generate_model_method(model_method_prompt:, idx:)
    generate_code_block_model_method model_method_prompt: model_method_prompt, idx: idx
  end


  # def generate_env
  #   generate_code_block area: :environment
  # end

  def generate_migration

  end

end
