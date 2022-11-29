# DESCRIPTION
# write a ruby roda route
# IMPLEMENTATION
r.root {
  "hello world"
}
# DESCRIPTION
# write a ruby roda route - get /hello - renders "OK World!"
# IMPLEMENTATION
r.get "hello" {
  "OK World!"
}
# DESCRIPTION
# write a ruby roda route - post /messages - saves a message
# IMPLEMENTATION
r.post "messages" {
  message_text = params["message_text"]
  message = Message.new message_text: message_text
  status = message.save
  {
    status: status,
    message: {
      id: message.id,
    },
  }
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - returns a single post
# IMPLEMENTATION
r.get "posts", Integer { |post_id|
  post = Post.get id: post_id
  {
    id:         post.id,
    title:      post.title,
    content:    post.content,
    created_at: post.created_at,
  }
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - returns a collection of posts with filters
# IMPLEMENTATION
r.get "posts" {
  posts = Post.all
  posts.map &:to_json
}
# DESCRIPTION
