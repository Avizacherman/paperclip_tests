json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :image, :author
  json.url post_url(post, format: :json)
end
