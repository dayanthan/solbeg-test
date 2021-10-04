json.extract! comment, :id, :body, :blog, :user_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
