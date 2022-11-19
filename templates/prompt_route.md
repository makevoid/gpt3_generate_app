# DESCRIPTION
# write a ruby roda route
# IMPLEMENTATION
r.root {
  "hello world"
}
# DESCRIPTION
# write a ruby roda route - get /hello - that renders "OK World!"
# IMPLEMENTATION
r.get "hello" {
  "OK World!"
}
# DESCRIPTION
# write a ruby roda route - post /messages - that saves a message
# IMPLEMENTATION
r.post "messages" {
  message_text = params["message_text"]
  message = Message.new message_text: message_text
  status = message.save
  { status: status }
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - that returns a single post
# IMPLEMENTATION
r.get "posts", Integer {
  "OK World!"
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - that returns a collection of posts with filters
# IMPLEMENTATION
r.get "posts" {
  posts = Post.all
  posts
}
# DESCRIPTION
