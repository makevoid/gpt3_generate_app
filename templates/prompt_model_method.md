# DESCRIPTION
# write a ruby model method Tweet.all that returns a list of tweets using Sequel 
# IMPLEMENTATION
def self.all
  new.all
end

def all
  tweets = DB[:tweets]
  tweets.all
end
# DESCRIPTION
# write a ruby model method using Sequel that gets a single tweet
# IMPLEMENTATION
def self.get(tweet_id:)
  new.get tweet_id: tweet_id
end

def get(tweet_id:)
  tweets = DB[:tweets]
  data = tweets.first id: tweet_id
  Tweet.new data
end
# DESCRIPTION
# write a ruby model method using Sequel that saves a blog post
# IMPLEMENTATION
DB.create_table(:posts) do
  primary_key :id
end unless DB.table_exists? :posts
DB.alter_table(:posts) do
  add_column :content, String
  add_column :created_at, DateTime
end unless DB[:posts].columns.include? :content

def initialize(content:)
  @content = content
end

def save
  posts = DB[:posts]
  status = posts.insert {
    content:    @content,
    created_at: Time.now,
  }
  status
end
# DESCRIPTION
# write a ruby model method using ruby that gets a single tweet
# IMPLEMENTATION
def get(tweet_id:)
  data = R.hmget "tweets:#{tweet_id}"
  Tweet.new data
end
