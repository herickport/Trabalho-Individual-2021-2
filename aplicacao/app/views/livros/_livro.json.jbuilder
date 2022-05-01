# frozen_string_literal: true

json.extract! livro, :id, :titulo, :autor, :ano, :editora, :edicao, :livro_eletronico, :created_at, :updated_at
json.url livro_url(livro, format: :json)
