# DESCRIPTION
# write a ruby model method Tweet.all that returns a list of tweets using Sequel, initializing each tweet with the fields id, text, completed
# IMPLEMENTATION
def self.all
  tweets = DB[:tweets]
  tweets = tweets.all 
  tweets
end
# DESCRIPTION
# write a ruby model method using Sequel that gets a single tweet
# IMPLEMENTATION
def self.get(tweet_id:)
  tweets = DB[:tweets]
  tweet = tweets.first id: tweet_id
  tweet
end
# DESCRIPTION
# write a ruby model method using Sequel that creates a blog post
# IMPLEMENTATION
def self.create(content:)
  posts = DB[:posts]
  post_id = posts.insert(
    content:    content,
    created_at: Time.now,
  )
  {
    status: !!post_id,
    id:     post_id,
  }
end
# DESCRIPTION
# write a ruby model method using redis that gets a single tweet
# IMPLEMENTATION
def self.get(tweet_id:)
  tweet = R.hmget "tweets:#{tweet_id}"
  tweet
end
# DESCRIPTION
# write a ruby model method Post.all that gets all posts using Sequel, sorted by created_at desc
# IMPLEMENTATION
def self.all
  posts = DB[:posts]
  posts = posts.order(:created_at).reverse
  posts = posts.all
  posts
end
# DESCRIPTION
# write a ruby model method Post.get that gets a single posts using Sequel and includes all the comments linked to the post
# IMPLEMENTATION
def self.get(id:)
  post = DB[:posts].first id: id 
  comments = DB[:comments].where post_id: id 
  comments = comments.order(:created_at).reverse
  comments = comments.all
  comments.each { |comment| comment.delete :post_id }
  post[:comments] = comments
  post  
end
# DESCRIPTION
