require_relative "../../test_app/env"

class CurrentUser
  def id
    1
  end
end

module CurrentUserUtil
  def current_user
    CurrentUser.new
  end
end

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger
  plugin :indifferent_params

  include CurrentUserUtil

  route do |r|
    r.root {
      { status: "ok" }
    }

<ROUTES>
  end
end
