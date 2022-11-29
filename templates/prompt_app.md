# DESCRIPTION
# write application requirements for an application that is a twitter clone
# IMPLEMENTATION
- model Tweet - Sequel - id, text, user_id, created_at, retweets_count
- model method Tweet.all - gets all tweets using Sequel, sorted by created_at desc
- model method tweet.new - initializes a tweet with id, text and user_id
- model method tweet.save - creates one tweet using Sequel saving the text, the current user id, the current time as created_at and retweets counts set to 0
- roda route get /tweets - returns a list of tweets
- roda route post /tweet - takes tweet_text and creates a tweet saving the text and the current user id
# DESCRIPTION
# write application requirements for a application that is a weather application
# IMPLEMENTATION
- model Weather - openweathermap
- model method Weather.get(city_name:) - calls openweathermap `/data/2.5/weather` API setting api_key to OPENWEATHERMAP_API_KEY
- roda route get /weather - gets weather for a location
# DESCRIPTION
# write application requirements for an application that is a full-fledged twitter clone
# IMPLEMENTATION
- model Tweet - Sequel - id, text, user_id, created_at, retweets_count
- model method Tweet.all - gets all tweets using Sequel, sorted by created_at desc
- model method tweet.new - initializes a tweet with id, text and user_id
- model method tweet.save - creates one tweet using Sequel saving the text, the current user id, the current time as created_at and retweets counts set to 0
- model method tweet.get - gets all details of a single tweet using Sequel, hydrating the user
- model method Tweet.all_user(user_id:) - gets all tweets of a user using Sequel, sorted by created_at desc
- model method Tweet.all_users(user_ids:) - gets all tweets of a series of user using Sequel, sorted by created_at desc
- model method Tweet.feed(user_id:) - gets all the users the user is following, get all the tweets of these users using Tweet.all_users(user_ids:) using Sequel, sorted by created_at desc
- roda route get /tweets - gets tweet with id
- roda route post /tweet - takes tweet_text and saves it
- roda route get /tweet/:tweet_id - gets the details of a single tweet and the user details
- roda route get /tweets - gets the tweets in the global feed - return a list of tweets from all users
- roda route get /users/:username/tweets - gets all tweets tweeted by a particular user
- roda route get /users/:username/feed - gets all tweets of the users that :username is following
- roda route post /tweet/:tweet_id/retweet - retweets tweet identified by :tweet_id
# DESCRIPTION
# write application requirements for an application that <PROMPT>
