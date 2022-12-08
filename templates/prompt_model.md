# DESCRIPTION
# write a ruby model Weather using openweathermap
# IMPLEMENTATION
class Weather
  API_ROOT = "https://api.openweathermap.org/data/2.5"
  
<MODEL_METHODS>
end
# DESCRIPTION
# write a ruby model Todo using Sequel - id, text, complete, created_at - complete is false by default
# IMPLEMENTATION
DB.create_table(:todos) do
  primary_key :id
  column :text, String
  column :complete, Boolean
  column :created_at, DateTime
end unless DB.table_exists? :todos

class Todo
  attr_reader :id, :created_at
  attr_accessor :content, :complete

<MODEL_METHODS>
end
# DESCRIPTION
# write a ruby model Tweet using Sequel - id, text, user_id, created_at, retweets_count
# IMPLEMENTATION
DB.create_table(:tweets) do
  primary_key :id
  column :text, String
  column :user_id, Integer
  column :created_at, DateTime
  column :retweets_count, Integer
end unless DB.table_exists? :tweets

class Tweet
  attr_reader :id, :user_id, :created_at, :retweets_count
  attr_accessor :text

<MODEL_METHODS>
end
# DESCRIPTION
