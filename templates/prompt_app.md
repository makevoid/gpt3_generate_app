# DESCRIPTION
# write application requirements for an application that is a twitter clone
# IMPLEMENTATION
- model Tweet using Sequel - id, text, user_id, created_at, retweets_count
- model method Tweet.all - gets all tweets using Sequel, sorted by created_at desc
- model method Tweet.create - creates one tweet using Sequel saving the text, the current user id, the current time as created_at and retweets counts set to 0
- roda route get /tweets - returns a list of tweets
- roda route post /tweet - takes text and creates a tweet saving the text and the current user id
# DESCRIPTION
# write application requirements for a application that is a weather application
# IMPLEMENTATION
- model Weather using openweathermap
- model method Weather.get(city_name:) - calls openweathermap `/data/2.5/weather` API setting api_key to OPENWEATHERMAP_API_KEY
- roda route get /weather - gets weather for a location
# DESCRIPTION
# write application requirements for an application that is a blog with posts and comments
# IMPLEMENTATION
- model Post using Sequel - id, title, content, created_at
- model method Post.all - gets all posts using Sequel, sorted by created_at desc
- model method Post.create - creates one post using Sequel saving title, content, the current time as created_at
- model method Post.get(id:) - gets all details of a single post using Sequel and getting the comments
- model Comment using Sequel - id, username, text, post_id, created_at
- model method Comment.all(post_id:) - gets all comments related to one post using Sequel, sorted by created_at desc
- model method Comment.create - creates one comment using Sequel saving username, text, post_id and current time as created_at
- roda route get /posts - gets all posts
- roda route get /posts/:post_id - gets the details of a single post and the post comments attributes
- roda route post /posts - takes the title and content params and creates a post saving them using Post.create
- roda route post /posts/:post_id/comments - creates a comment for a post passing the username and text params
# DESCRIPTION
# write application requirements for an application that <PROMPT>
