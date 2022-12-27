# twitter clone - full

# DESCRIPTION
# write application requirements for an application that is a full-fledged twitter clone
# IMPLEMENTATION
- model Tweet using Sequel - id, text, user_id, created_at, retweets_count
- model method Tweet.all - gets all tweets using Sequel, sorted by created_at desc
- model method Tweet.create - creates one tweet using Sequel saving the text, the current user id, the current time as created_at and retweets counts set to 0
- model method tweet.get - gets all details of a single tweet using Sequel, hydrating the user
- model method Tweet.all_user(user_id:) - gets all tweets of a user using Sequel, sorted by created_at desc
- model method Tweet.all_users(user_ids:) - gets all tweets of a series of user using Sequel, sorted by created_at desc
- model method Tweet.feed(user_id:) - gets all the users the user is following, get all the tweets of these users using Tweet.all_users(user_ids:) using Sequel, sorted by created_at desc
- model method Tweet.retweets(tweet_id:) - gets all tweets which are retweets of a tweet using Sequel, sorted by created_at desc
- roda route get /tweets - gets tweet with id
- roda route post /tweet - takes text and saves it
- roda route get /tweet/:tweet_id - gets the details of a single tweet and the user details
- roda route get /tweets - gets the tweets in the global feed - return a list of tweets from all users using Tweet.all_user
- roda route get /users/:username/tweets - gets all tweets tweeted by a particular user using Tweet.all_user
- roda route get /users/:username/feed - gets all tweets of the users that :username is following using Tweet.feed
- roda route post /tweet/:tweet_id/retweet - retweets tweet identified by :tweet_id