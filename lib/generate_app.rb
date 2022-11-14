module GenerateApp
  include Generators

  def generate_all

  end
end

module Generators

  TEMPLATES = %i(
    app
    css
    ...
  )

  # Generators
  # ---
  # app
  # models
  # environment
  # css
  # layout
  # index_page
  # secondary_page

  GENERATORS = {
    app: {
      filepath: "app.rb",
    },
    models: {
      filepath: "models.rb"
    },
    environment: {
      filepath: "env.rb"
    },
    css: {
      filepath: "public/css/style.css",
    },
    layout: {
      filepath: "views/layout.haml",
    },
    index_page: {
      filepath: "views/index.haml",
    },
    secondary_page: {
      filepath: "views/page2.haml",
    },
    # controller_action_index: {
    #   filepath: "app.rb",
    # },
    # controller_action_page2: {
    #   filepath: "app.rb",
    # },
  }


  def generate_roda_app

  end

  def method_name

  end
