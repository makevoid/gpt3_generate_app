class GPT3MockResponse

APP_TODO_SQLITE = "
- get /todos - lists all todos
- post /todos - inserts a new todo
"

ROUTE_TODOS_GET = "
r.get(\"todos\") {
  todos = Todo.all
  todos.map &:to_json
}
"

ROUTE_TODOS_POST = "
r.post(\"todos\") {
  todo_text = params[\"todo_text\"]
  todo = Todo.new todo_text: todo_text
  status = todo.save
  {
    status: status,
    todo: {
      id: todo.id,
    },
  }
}
"

  RESPONSES = {
    # input regex => mock output
    /requirements .+ application .+ todo list app .+ sequel/i => APP_TODO_SQLITE,
    /get \/todos \- lists .+ todos/i => ROUTE_TODOS_GET,
    /post \/todos \- inserts .+ todo/i => ROUTE_TODOS_POST,
    # ...
  }

  def initialize(input:)
    @input = input
  end

  def body
    response = RESPONSES.find do |input, output|
      @input =~ input
    end
    raise "MockedInputNotMatchedError - couldn't match input: #{@input.inspect}" unless response
    response = response.last
    response.strip!
    wrap_response response: response
  end

  def wrap_response(response:)
    {
      "choices": [
        { "text": response }
      ]
    }.to_json
  end

end

module MockPromptUtils
  def parse_prompt_last_input(prompt:)
    stop_token = GPT3_STOP_TOKENS.first
    split = prompt.split stop_token
    result = split.last
    result.sub!  GPT3_STOP_TOKENS.last, ''
    result.strip!
    result
  end
end

class GPT3Mock
  include MockPromptUtils

  def initialize
    # ...
  end

  def self.completions(engine:, parameters:)
    new.completions(
      engine:     engine,
      parameters: parameters,
    )
  end

  def completions(engine:, parameters:)
    prompt_last_input = parse_prompt_last_input prompt: parameters.f(:prompt)
    puts "PROMPT: #{prompt_last_input.inspect}"
    GPT3MockResponse.new(input: prompt_last_input)
  end
end
