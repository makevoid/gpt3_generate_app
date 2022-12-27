class GPT3MockResponse

APP_TODO_SQLITE = "
- model Todo using Sequel - id, text, complete, created_at - complete is false by default
- model method Todo.all - gets all todos using Sequel, sorted by created_at desc
- model method todo.new - initializes a todo with `text`
- model method todo.save - creates one tweet using Sequel saving the text and the current time as created_at
- roda route get /todos - lists all todos
- roda route post /todos - inserts a new todo
"

ROUTE_TODOS_GET = "
r.get(\"todos\") {
  todos = Todo.all
  todos.map &:to_json
}
"

ROUTE_TODOS_POST = "
r.post(\"todos\") {
  text = params[:text]
  todo = Todo.new text: text
  status = todo.save
  {
    status: status,
    todo: {
      id: todo.id,
    },
  }
}
"

MODEL_METHOD_TODO_ALL = "
def self.all
  new.all
end

def all
  todos = DB[:todos]
  todos = todos.reverse :created_at
  todos.all
end
"

MODEL_METHOD_TODO_INITIALIZER = "
def initialize(text:)
  @text = text
end
"

MODEL_METHOD_TODO_SAVE = "
def save
  todos = DB[:todos]
  status = todos.insert(
    text:       @text,
    created_at: Time.now,
  )
  status
end
"

MODEL_TODO = "
DB.create_table(:todos) do
  primary_key :id
  column :text, String
  column :complete, TrueClass
  column :created_at, DateTime
end unless DB.table_exists? :todos

class Todo
  attr_reader :id, :created_at
  attr_accessor :content, :complete

<MODEL_METHODS>
end
"

  RESPONSES = {
    # input regex => mock output
    # ---
    # application
    /requirements .+ application .+ todo list app .+ sequel/i => APP_TODO_SQLITE,
    # routes
    /get \/todos \- lists .+ todos/i => ROUTE_TODOS_GET,
    /post \/todos \- inserts .+ todo/i => ROUTE_TODOS_POST,
    # model methods
    /model method Todo.all - gets all todos/ => MODEL_METHOD_TODO_ALL,
    /todo.new - initializes a todo/ => MODEL_METHOD_TODO_INITIALIZER,
    /todo.save - creates one tweet / => MODEL_METHOD_TODO_SAVE,
    # model
    /ruby model Todo using Sequel/ => MODEL_TODO,
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
