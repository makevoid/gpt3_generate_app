require_relative "../../test_app/env"

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger

  route do |r|
    r.root {
      { status: "ok" }
    }

<ROUTES>
  end
end
