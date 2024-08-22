json.extract! post, :id, :titulo, :subtitulo, :descricao, :data, :created_at, :updated_at
json.url post_url(post, format: :json)
