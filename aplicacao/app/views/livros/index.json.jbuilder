# frozen_string_literal: true

json.array! @livros, partial: 'livros/livro', as: :livro
