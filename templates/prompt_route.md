# DESCRIPTION
# write a ruby roda route
# IMPLEMENTATION
r.root {
  "hello world"
}
# DESCRIPTION
# write a ruby roda route - get /hello - renders "OK World!"
# IMPLEMENTATION
r.get("hello") {
  "OK World!"
}
# DESCRIPTION
# write a ruby roda route - post /messages - saves a message
# IMPLEMENTATION
r.post("messages") {
  text = params[:text]
  resp = Message.create text: text
  {
    status: resp[:status],
    message: {
      id: resp[:id],
    },
  }
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - returns a single post
# IMPLEMENTATION
r.get("posts", Integer) { |post_id|
  post = Post.get id: post_id
  post = {
    id:         post[:id],
    title:      post[:title],
    content:    post[:content],
    created_at: post[:created_at],
  }
  post 
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - returns a collection of posts with filters
# IMPLEMENTATION
r.get("posts") {
  posts = Post.all
  posts
}
# DESCRIPTION
# write a ruby roda route - get /posts/:post_id - gets the details of a single post and the post comments attributes
# IMPLEMENTATION
r.get("posts", Integer) { |post_id|
  post = Post.get id: post_id
  post = {
    id:         post[:id],
    title:      post[:title],
    content:    post[:content],
    created_at: post[:created_at],
    comments:   post[:comments],
  }
  post 
}
# DESCRIPTION
