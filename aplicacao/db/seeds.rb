# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.create!(email: 'user@email.com', password: '123456', role: :admin)
Livro.create(
  titulo: 'Código Limpo: Habilidades Práticas do Agile Software',
  autor: 'Robert C. Martin',
  ano: 2019,
  editora: 'Alta Books',
  edicao: 2,
  livro_eletronico: true
)
Livro.create(
  titulo: 'Arquitetura limpa: O guia do artesão para estrutura e design de software',
  autor: 'Robert C. Martin',
  ano: 2019,
  editora: 'Alta Books',
  edicao: 2,
  livro_eletronico: true
)
Livro.create(
  titulo: 'Extreme Programming Explained: Embrace Change',
  autor: 'Kent Beck, Cynthia Andres',
  ano: 2004,
  editora: 'Addison-Wesley Professional',
  edicao: 2,
  livro_eletronico: true
)
Livro.create(
  titulo: 'Design Patterns: Elements of Reusable Object-Oriented Software',
  autor: 'Gamma Erich, Helm Richard, Johnson Ralph, Vlissides John',
  ano: 1994,
  editora: 'Addison-Wesley Professional',
  edicao: 1,
  livro_eletronico: false
)
