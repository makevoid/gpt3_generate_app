class GPT3Prompt

  MODEL = "code-davinci-001" # no fine tune yet

  MAX_TOKENS = 600 # app

  STOP_TOKENS = GPT3_STOP_TOKENS

  PARAMETERS_DEFAULT = {
    max_tokens:         MAX_TOKENS,
    stop:               STOP_TOKENS,
    temperature:        0.3,
    top_p:              0.99,
    frequency_penalty:  0.01,
    presence_penalty:   0.01,
  }

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def self.generate(input:)
    new(input: input).generate
  end

  def generate
    resp = GPT3.completions(
      # model: MODEL,
      engine: MODEL,
      parameters: compleitions_params,
    )
    resp = parse_response response: resp
    resp.strip
  end

  def compleitions_params
    parameters = {
      prompt: input,
    }
    parameters.merge PARAMETERS_DEFAULT
  end

  def parse_response(response:)
    resp = response.body
    resp = JSON.parse resp
    resp = resp.f "choices"
    resp = resp.f 0
    resp.f "text"
  end

end
